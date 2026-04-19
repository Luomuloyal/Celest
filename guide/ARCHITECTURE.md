针对 Celest 的多端场景，当前推荐的结构是：

- **Feature-First**
- **全局依赖统一走 Riverpod**
- **Mobile 与 Wide Layout 分治**
- **只在需要时引入额外层级**

核心目录树：

```text
lib/
├── main.dart
├── bootstrap.dart                  # 启动入口：创建根依赖并注入 ProviderScope
├── app.dart                        # 应用根组件：主题、路由、国际化
│
├── core/
│   ├── common/
│   │   ├── providers/              # 全局共享 Provider 与 bootstrap overrides
│   │   ├── widgets/                # 跨模块通用组件与应用壳层
│   │   └── responsive_layout.dart  # 页面级断点分发
│   ├── constants/
│   ├── error/
│   ├── theme/
│   └── utils/
│
├── features/
│   ├── auth/
│   ├── competition/
│   │   ├── data/
│   │   │   └── repositories/       # 仓库实现
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   └── repositories/
│   │   └── presentation/
│   │       ├── pages/
│   │       ├── providers/          # feature 内的 Riverpod providers
│   │       └── widgets/
│   ├── dashboard/
│   └── team/
│
├── routes/
│   ├── app_routes.dart             # 命名路由常量
│   ├── app_router.dart             # GoRouter 配置
│   └── route_guard.dart            # 路由重定向与守卫
│
├── l10n/
└── services/
```

## 1. 依赖流

当前项目统一使用 Riverpod 管理依赖流。

- 启动阶段创建的实例，例如 `SharedPreferences`、`NotificationService`，在 `bootstrap.dart` 中初始化。
- 这些实例通过 `ProviderScope.overrides` 注入。
- Widget、主题控制器、业务模块只通过 `ref.read` / `ref.watch` 获取依赖。

这样做的好处：

- 只有一套依赖入口，测试和正式环境一致。
- 不需要额外的 Service Locator。
- 每个依赖的来源对调用方是显式可见的。

## 2. 特性层分工

### `domain/`

放稳定的业务抽象：

- Entity
- Repository 接口
- 真正有业务意义的规则

这里保持纯 Dart，不引入 Flutter UI 依赖。

### `data/`

放外部数据适配逻辑：

- Repository 实现
- DTO / Model
- Remote / Local datasource

注意：

- 只要功能存在 JSON DTO，`models/` 就是必需目录。
- JSON Model 必须使用 `json_serializable` 生成 `fromJson` / `toJson`，禁止手写解析。
- `datasources/` 仍然可以按实际复杂度决定是否拆出。
- 如果一个功能当前只有简单仓库实现，可以先只保留 `repositories/`。

### `presentation/`

放页面、局部组件和 Riverpod providers：

- `pages/` 负责页面入口与响应式分发
- `providers/` 负责 feature 内状态与依赖组合
- `widgets/` 放模块私有 UI

## 3. 响应式策略

当前断点标准：

- Mobile: `< 600`
- Tablet: `600 - 1024`
- Desktop / Wide Web: `> 1024`

推荐模式：

```dart
ResponsiveLayout(
  mobile: MobileView(),
  tablet: WideView(),
  desktop: WideView(),
)
```

也就是说：

- **宽屏 Web 与原生桌面默认共用一套宽屏布局**
- 只有确实存在少量交互差异时，才在 `WideView` 内做局部平台判断

## 4. 应用壳层

应用导航壳层集中在 `core/common/widgets/`：

- Mobile 使用底部导航
- Tablet / Desktop / Wide Web 使用共用的宽屏导航壳层

宽屏导航本身建议抽为独立组件，而不是把 tablet 和 desktop 分支各写一遍。

## 5. 路由约定

路由统一使用 `go_router`。

- 路径和名字统一收敛到 `app_routes.dart`
- 页面跳转优先使用命名路由
- Shell 级布局使用 `ShellRoute`

这样可以同时满足：

- Web URL 同步
- 浏览器前进后退
- 多端统一导航壳层

## 6. 复杂度控制原则

当前项目遵循下面的收敛原则：

- 不为单一透传逻辑单独加 `usecase`
- 不提前创建空 `datasource`、空 DTO、空 bloc/provider
- 不为了“以后可能用到”把一条简单链路拆成过多层
- 如果 Web 和 Desktop 几乎一致，就先共用宽屏实现

一句话概括：

**先让当前需求的链路最短、最清晰，再在真实复杂度出现时补抽象。**
