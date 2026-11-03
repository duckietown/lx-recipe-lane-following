#!/bin/bash

source /environment.sh

# This learning experience is not meant to be run with `dts code workbench`.
# The lane-following stack lives in the `dt-ros2-core` submodule of the exercise
# (`packages/dt-ros2-core`) and is built and run with the `dts devel` API:
#
#     cd packages/dt-ros2-core
#     dts devel build -H ROBOT_NAME
#     dts devel run -H ROBOT_NAME -L lane-following
#
# as described in the README.md and in notebooks/00_DTS_devel_API.ipynb.

cat <<'MSG'

This exercise is not meant to be run with `dts code workbench`.

Instead, navigate to the `packages/dt-ros2-core` directory (the dt-ros2-core
submodule) and run:

    dts devel build -H ROBOT_NAME
    dts devel run -H ROBOT_NAME -L lane-following

as described in the README.md file of this learning experience.

MSG
exit 0
