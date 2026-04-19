针对全终端适配（Mobile, Web, Desktop）的竞赛管理系统，采用**功能驱动（Feature-First）结合响应式布局管理**的结构

核心目录树 (lib/)

```text
lib/
├── main.dart               # 入口文件：初始化全局配置、环境加载
├── app.dart                # 应用根组件：配置主题、路由、国际化
├── injection_container.dart# 依赖注入 (DI) 中心：管理 Service Locator (如 GetIt)
│
├── core/                   # 核心基础层：与业务逻辑无关的通用代码
│   ├── common/             # 全局通用组件 (ResponsiveLayout, CommonButton 等)
│   ├── constants/          # 全局常量 (AppKeys, AssetPaths, Endpoints)
│   ├── error/              # 异常处理模型 (Failures, Exceptions)
│   ├── theme/              # 全局设计系统 (FlexColorScheme, TextTheme, 响应式间距)
│   └── utils/              # 工具与基础能力 (Validators, Formatters, PlatformInfo, Network)
│
├── features/               # 业务特性层：按功能模块划分 (Feature-First)
│   ├── auth/               # 示例：身份认证模块 (登录、权限校验)
│   ├── competition/        # 示例：竞赛管理模块 (发布、审核、报名)
│   │   ├── data/           # 数据层：负责获取数据
│   │   │   ├── datasources/# 远程 API 调用 & 本地缓存 (Hive/Isar)
│   │   │   ├── models/     # 数据传输对象 (DTO, JSON 序列化)
│   │   │   └── repositories/# 仓库实现类 (实现 Domain 层的接口)
│   │   ├── domain/         # 领域层：核心业务逻辑 (纯 Dart)
│   │   │   ├── entities/   # 核心业务对象
│   │   │   ├── repositories/# 仓库接口定义
│   │   │   └── usecases/   # 具体用例 (如：GetCompetitionList, JoinCompetition)
│   │   └── presentation/   # 表现层：UI 与 状态管理
│   │       ├── bloc/       # 状态管理逻辑 (也可是 Riverpod/Provider)
│   │       ├── pages/      # 页面入口 (根据响应式逻辑分发子组件)
│   │       └── widgets/    # 模块内私有组件 (包含桌面端/移动端特有组件)
│   │
│   └── team/               # 示例：组队模块
│   └── dashboard/          # 示例：数据大屏/工作台
│
├── routes/                 # 路由管理
│   ├── app_router.dart     # GoRouter 配置 (支持 Web URL 同步与深度链接)
│   └── route_guard.dart    # 路由守卫 (登录拦截、角色权限控制)
│
├── l10n/                   # 多语言国际化 (arb 文件)
└── services/               # 独立系统服务 (文件上传服务、WebSocket 监听)
```

## 关键目录职能说明

### 核心层 (Core)

- **`core/utils/network/`**: 这里是你作为后端开发最关注的地方。建议封装统一的 `ApiClient`，处理 JWT 自动刷新、PostgreSQL 错误码转义等逻辑。
- **`core/theme/`**: 全终端适配的关键。除了颜色，还需定义 `AppSpacing`（间距）和 `AppBreakpoints`（断点）。例如：Web 端侧边栏宽度、移动端底部导航栏高度。

### 特性层 (Features) - 遵循 Clean Architecture

- **`domain/` (领域层)**: 系统的“大脑”。即使你以后把 Flutter 换成别的框架，这里的逻辑（如：竞赛报名必须满足XX条件）是不变的。
- **`data/` (数据层)**: 你的后端接口适配器。负责把从 Node.js 获取的原始 JSON 转换为应用内部使用的 Entity。
- **`presentation/` (表现层)**:
  - **响应式策略**: 推荐在 `pages/` 中使用 `ResponsiveLayout(mobile: ..., tablet: ..., desktop: ...)`。
  - **代码复用**: 业务逻辑在 BLoC/Cubit 中共用，只有 UI 排版因端而异。

### 路由层 (Routes)

- **`app_router.dart`**: 在全终端应用中，路由必须支持 Web 浏览器的“前进/后退”和 URL 参数解析。推荐使用 `go_router` 插件，它能完美处理桌面端的多窗口和 Web 端的路径映射。

------

## 3. 全终端适配开发建议 (随时参考)

1. **断点标准**:
   - Mobile: < 600px
   - Tablet: 600px - 1024px
   - Desktop: > 1024px
2. **输入方式兼容**:
   - 移动端考虑“手势操作”与“下拉刷新”。
   - 桌面端/Web 端加强“鼠标悬停 (Hover)”状态反馈和“键盘快捷键”。
3. **存储策略**:
   - 涉及本地数据存储时，使用 `Hive` 或 `Isar`，它们对原生端和 Web 端都有良好的支持。
4. **Backend 契约**:
   - 由于你是后端负责人，建议模型类（Models）严格对应 PostgreSQL 的 Schema，并利用 `json_serializable` 自动化处理，减少手动解析导致的 bug。
