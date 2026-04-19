这是一份项目开发规范文档。它结合了技术栈和多端适配需求，专门为保证团队协作质量而编写。

------

# Celest竞赛管理系统 - 前端开发规范

## 1. 架构与设计原则

本项目致力于打造一个高可用、全终端适配（Web/Desktop/Mobile）的高校竞赛全生命周期管理平台。

为避免代码严重耦合，前端采用 **整洁架构 (Clean Architecture)** 与 **按功能模块划分 (Feature-First)** 相结合的模式。

- **单一职责原则**：UI 层只负责渲染，业务逻辑必须抽离到状态管理层，数据解析必须在数据层完成。
- **依赖反转**：高层模块（业务逻辑）不应依赖低层模块（网络请求/数据库），两者都应依赖其抽象接口（Repositories）。
- **防御性编程**：不要信任任何外部数据输入。从 go 后端获取的数据必须经过严谨的模型转换和异常捕获。

## 2. 核心技术栈

- **UI 框架**: Flutter (支持 Web/Android/iOS/Windows/macOS)
- **状态管理**: `Riverpod`
- **路由管理**: `go_router` (完美支持 Web URL 路径与深度链接)
- **网络请求**: `dio` + 拦截器封装
- **数据序列化**: `json_serializable` 与 `build_runner` (禁止手动解析 JSON)
- **本地存储**: `shared_preferences` (轻量配置) /`hive` (复杂业务缓存)
- **依赖注入**: `get_it`

## 3. 命名与代码风格规范

严格遵循官方(https://dart.dev/guides/language/effective-dart)。

- **文件名 / 目录名**: 使用小写加下划线 (`snake_case`)。例如：`competition_list_page.dart`。
- **类名 / 枚举名**: 使用大驼峰 (`PascalCase`)。例如：`CompetitionRepository`。
- **变量名 / 方法名**: 使用小驼峰 (`camelCase`)。例如：`fetchCompetitionData()`。
- **私有变量**: 必须以下划线开头 (`_privateVariable`)。
- **Widget 构建**:
  - 复杂的 UI 必须拆分为独立的 `StatelessWidget` 类，**严禁**写出几千行的大胖子文件。
  - 优先使用 `const` 构造函数，以极致优化渲染性能。

## 4. 目录结构约束

所有功能模块必须存放在 `lib/features/` 下，且必须遵循三层架构：

1. `domain/` (领域层)：存放纯 Dart 业务逻辑、实体类 (Entity) 和仓库接口，绝对禁止引入 `flutter/material.dart`。
2. `data/` (数据层)：实现领域层的接口，负责与后端 API 或本地数据库交互，将 JSON 转为 Entity。
3. `presentation/` (表现层)：存放页面、局部 Widget 和状态管理器，禁止直接调用 `dio`。

*(详细目录树请参考 `ARCHITECTURE.md` 架构文档)*

网络请求相关封装统一放在 `lib/core/utils/network/` 下，例如 `ApiClient`、错误处理器和请求拦截器；业务页面与表现层只能依赖数据层抽象，不能直接依赖这些网络实现。

## 5. 多终端适配约定

为了实现一套代码多端完美运行，UI 层必须遵循以下适配原则：

- **禁止硬编码尺寸**：慎用绝对固定的宽高（如 `width: 300`）。使用相对布局、`Expanded`、`Flexible` 或使用统一的 `AppSpacing` 常量。
- **响应式断点 (Breakpoints)**：
  - **Mobile (移动端)**: 屏幕宽度 `<600px` (平板/折叠屏)**: (手机竖屏) (桌面/Web端)**: * **Desktop **Tablet 1024px`<` `600px 屏幕宽度>= 1024px`
- **交互兼容**：
  - 列表需同时支持触摸滑动（Mobile）与鼠标滚轮（Desktop）。
  - PC 端复杂的表单或表格，在移动端需降级为卡片式信息流展示，使用 `ResponsiveLayout` 组件分发视图。

## 6. 后端对接与数据处理约定

前端需与后端 (Node.js + PostgreSQL) 保持紧密的契约精神。

- **接口统一管理**：所有 API 请求路径统一配置在 `core/constants/api_endpoints.dart` 中。
- **PostgreSQL 数据映射**：
  - 后端数据库的 `snake_case` 字段，在前端 Model 中必须通过 `@JsonKey(name: 'field_name')` 映射为 Dart 的 `camelCase` 规范。
  - 注意处理 PostgreSQL 中可能为空 (Nullable) 的字段，前端模型中对应类型必须加 `?`，防止解析崩溃。
- **安全与鉴权**：
  - JWT Token 统一在 Dio 拦截器中无感注入请求头。
  - 无感刷新 Token 或 401 登出逻辑封装在全局拦截器中，不在业务页面处理。
- **异常拦截**：所有后端抛出的异常（如业务错误码 40x，服务器错误 50x）必须在 `data` 层被捕获，并转化为标准的 `Failure` 对象传递给 UI 层，严禁将原始 Error 直接抛给页面。

## 7. Git 协作与提交规范

采用功能分支工作流 (Feature Branch Workflow)。禁止直接向 `main` 或 `master` 分支推送代码。

**提交信息 (Commit Message) 格式：**

```
<type>(<scope>): <subject>
```

- `feat`: 新增功能 (Feature)
- `fix`: 修复 Bug
- `ui`: 纯 UI 样式调整
- `refactor`: 重构代码（不改变现有功能的代码变动）
- `docs`: 文档修改
- `chore`: 构建过程或辅助工具的变动 (如更新 pubspec.yaml)

**示例：**

```
feat(auth): 新增登录页面的响应式布局
fix(competition): 修复比赛列表时间格式化错误
```
