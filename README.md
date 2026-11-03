# LX Recipe: Lane Following (ROS 2)

Recipe for the [lx-lane-following](https://github.com/duckietown/lx-lane-following) learning experience on the
ROS 2 (Jazzy, `rmw_zenoh_cpp`) Duckietown stack, `ente` distro.

## How this LX is different

This LX does **not** run its code through `dts code workbench`. It teaches the `dts devel` workflow on the
core lane-following stack, which the LX vendors as the git submodule `packages/dt-ros2-core`
([dt-ros2-core](https://github.com/duckietown/dt-ros2-core), branch `ente`). Students build and run it with:

```bash
cd packages/dt-ros2-core
dts devel build -H ROBOT_NAME
dts devel run -H ROBOT_NAME -L lane-following     # launchers/lane-following.sh
```

after bringing the ROS 2 stack up on the robot (`dts stack up -H ROBOT_NAME ros2/duckiebot` and
`dts stack up -H ROBOT_NAME ros2-core/default`).

Consequences for this recipe:

- `launchers/default.sh` only prints a message pointing at the `dts devel` workflow (it sources
  `/environment.sh` and exits cleanly), so `dts code workbench` is harmless but useless here.
- The LX ships a `.dockerignore` that excludes `packages/dt-ros2-core` from the `meat` build context: the
  workbench image (`Dockerfile`, based on `dt-ros2-commons`) runs `colcon build` over everything under
  `packages/`, and the whole core stack (plus its apt/pip dependencies, duckiedrone packages included) must not
  be built into the exercise image. The submodule is built by `dts devel build` on the robot instead.
- The editor image (`Dockerfile.vscode`) is where the notebooks run: it carries ROS 2 Jazzy, the
  `duckietown_msgs` and the `lx_ros2_tools` notebook panels (`RosSession`, `ImageView`, `TopicPlot`,
  `ParamPanel`) so that the notebooks can look at the robot's debug images and tune parameters live, and the
  integrated terminal has the `ros2` CLI connected to the robot's zenoh router.

## Files

| File | Role |
|---|---|
| `Dockerfile` | workbench image (`dt-ros2-commons` base, ROS 2 template) |
| `Dockerfile.vscode` | editor image (`dt-vscode` base + ROS 2 Jazzy, template) |
| `dependencies-apt.txt` | apt deps of the workbench image (`graphviz` for the FSM diagram) |
| `dependencies-apt.vscode.txt` | apt deps of the editor image (ROS 2 Jazzy packages, `graphviz`) |
| `dependencies-py3.txt` | pip deps of both images: `graphviz`, `lib-dt-computer-vision`, `lib-dt-state-estimation` (notebook 03), `ipywidgets`, `ipympl`, `matplotlib` (panels) |
| `launchers/default.sh` | message launcher (see above) |
| `packages/lx_ros2_tools/` | shared notebook helpers (verbatim copy, do not edit here) |
| `assets/vscode/setup.sh`, `assets/vscode/launch.sh` | editor setup hooks (README at startup, widgets, ROS 2 in the terminal, colcon output dirs) |
| `assets/duckiematrix/` | Duckiematrix map used by `dts code start_matrix` (`settings.yaml`) |

## Dependencies

Specify any `apt` or `python` dependencies needed in [dependencies-apt.txt](./dependencies-apt.txt),
[dependencies-apt.vscode.txt](./dependencies-apt.vscode.txt) and [dependencies-py3.txt](./dependencies-py3.txt).
`dependencies-py3.txt` is installed in both images.

## Duckiematrix

By default, each LX is compatible with the [Duckiematrix](https://docs.duckietown.com/ente/devmanual-duckiematrix/intro.html).
See the [README in the LX template](https://github.com/duckietown/template-lx/blob/ente/README.md)
for more details on how to deploy this capability through the `dts code` API.
You can define the exact configuration of the Duckiematrix environment in the
[assets/duckiematrix](./assets/duckiematrix) directory. For more details see
[the Duckiematrix manual](https://docs.duckietown.com/ente/devmanual-duckiematrix/intro.html).
