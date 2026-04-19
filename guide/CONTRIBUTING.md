这是一份面向 Celest 项目的前端协作规范，目标是让代码在 Web、Desktop、Mobile 三端保持一致的结构、清晰的依赖流和可控的复杂度。

------

# Celest 竞赛管理系统 - 前端开发规范

## 1. 架构与设计原则

本项目采用 **Feature-First** 目录组织，并结合 **轻量化 Clean Architecture**。

- **全局依赖流统一使用 Riverpod**：
  运行时依赖通过 `Provider` / `NotifierProvider` / `FutureProvider` 暴露。
  应用启动阶段创建的全局实例，通过 `ProviderScope.overrides` 注入。
- **UI 只负责渲染和交互**：
  页面与 Widget 不直接发起网络请求，不直接解析 JSON。
- **业务抽象按需引入**：
  Repository 接口保留在 `domain`，具体实现放在 `data`。
  `usecase` 不是强制层，只有在业务动作跨多个对象、需要复用、或包含明显业务规则时才新增。
- **避免为了架构而架构**：
  单纯透传的一层不要强行拆成多层；占位文件、空抽象、未使用 DTO 不要提前堆满。
- **Web / Desktop 默认共享宽屏布局**：
  只有当交互或信息密度真的不同，才在宽屏内部再做分支。

## 2. 核心技术栈

- **UI 框架**: Flutter
- **状态管理 / 依赖提供**: `flutter_riverpod`
- **路由管理**: `go_router`
- **网络请求**: `dio`
- **JSON 序列化**: `json_serializable` + `build_runner`
- **本地存储**: `shared_preferences` / `hive`
- **通知能力**: `flutter_local_notifications`

## 3. 状态管理与依赖约定

- 全局共享实例统一定义在 `lib/core/common/providers/`。
- 业务模块自己的状态与依赖定义在 `lib/features/<feature>/presentation/providers/`。
- 简单只读依赖使用 `Provider`。
- 异步加载列表优先使用 `FutureProvider`。
- 需要可变状态时使用 `NotifierProvider` 或 `AsyncNotifierProvider`。
- 禁止重新引入 `get_it` 之类的第二套依赖注入通道。

## 4. 命名与代码风格

严格遵循 Effective Dart。

- **文件名 / 目录名**: `snake_case`
- **类名 / 枚举名**: `PascalCase`
- **变量名 / 方法名**: `camelCase`
- **私有成员**: 以下划线开头
- **Widget 拆分**:
  复杂 UI 必须拆成独立 Widget，避免超长页面文件。
- **const 优先**:
  能写 `const` 的地方尽量写 `const`。

## 5. 目录结构约束

所有业务功能放在 `lib/features/` 下，并遵循下面的最小分层：

1. `domain/`
   放纯 Dart 实体、仓库接口，以及真正有业务价值的领域规则。
2. `data/`
   放仓库实现、DTO、远程或本地数据访问逻辑。
   如果当前功能只需要一个简单仓库实现，可以先不拆 `datasources/`。
3. `presentation/`
   放页面、局部 Widget 和 Riverpod providers。

补充约束：

- 页面与表现层禁止直接依赖 `dio`。
- 网络能力统一收敛在 `lib/core/utils/network/`。
- 路由常量统一放在 `lib/routes/app_routes.dart`。
- 命名路由统一通过 `goNamed` / `pushNamed` 使用，避免散落硬编码路径。

## 6. 多终端适配约定

- **断点标准**
  - Mobile: `< 600`
  - Tablet: `600 - 1024`
  - Desktop / Wide Web: `> 1024`
- **布局原则**
  - Mobile 使用紧凑布局。
  - Tablet、Desktop、宽屏 Web 默认共享宽屏壳层。
  - 只有在少量交互差异存在时，才在宽屏内部做局部条件分支。
- **尺寸约定**
  - 避免直接写死宽高。
  - 优先使用 `Expanded`、`Flexible`、`LayoutBuilder`、`MediaQuery`、`AppSpacing`、`AppSizes`。
- **响应式入口**
  - 页面级适配统一走 `ResponsiveLayout`。
- **交互兼容**
  - 列表和滚动区域同时考虑触摸与鼠标滚轮。
  - 宽屏端需要考虑 hover、焦点和键盘导航。

## 7. 后端对接与数据处理约定

- API 路径统一配置在 `core/constants/api_endpoints.dart`。
- JSON 到业务对象的转换必须发生在 `data` 层，不放在页面里。
- 禁止手动解析 JSON；序列化与反序列化统一通过 `json_serializable` 生成代码处理。
- 外部输入默认不可信，异常需要在 `data` 层被拦截和标准化。
- 只要出现 JSON DTO，就必须建立 `Model` 并使用插件生成 `fromJson` / `toJson`。

## 8. Git 协作与提交规范

采用功能分支工作流，禁止直接向 `main` 推送。

提交信息格式：

```text
<type>(<scope>): <subject>
```

常用类型：

- `feat`: 新增功能
- `fix`: 修复问题
- `ui`: 纯界面调整
- `refactor`: 不改变功能的重构
- `docs`: 文档修改
- `chore`: 工具链或依赖调整

示例：

```text
feat(auth): 新增登录页响应式布局
refactor(shell): 抽取宽屏导航组件
fix(competition): 修正赛事列表刷新逻辑
```
