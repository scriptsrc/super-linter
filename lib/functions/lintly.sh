#!/usr/bin/env bash

################################################################################
################################################################################
########### Super-Linter lintly Function(s) @scriptsrc #########################
################################################################################
################################################################################
########################## FUNCTION CALLS BELOW ################################
################################################################################
################################################################################
#### Function InvokeLintly #####################################################
function InvokeLintly() {
  # Call comes through as:
  # InvokeLintly "${LINTLY_FORMAT}" "${LINTER_COMMAND_OUTPUT}"

  ####################
  # Pull in the vars #
  ####################
  LINTLY_FORMAT="{$1}" && shift
  LINTER_COMMAND_OUTPUT="${2}" && shift

  # Lintly will comment on the PR
  echo "$LINTER_COMMAND_OUTPUT" | lintly --format="${LINTLY_FORMAT}"

}

function SupportsLintly() {
  # Call comes through as:
  # SupportsLintly "${LANGUAGE}"

  ####################
  # Pull in the vars #
  ####################
  LANGUAGE="{$1}" && shift

  [[ -v LINTLY_SUPPORT_ARRAY["${LANGUAGE}"] ]] && return 0
  return 1
  
}

##################################
# Lintly language suppport array #
##################################
declare -A LINTLY_SUPPORT_ARRAY
LINTLY_SUPPORT_ARRAY['PYTHON_FLAKE8']="flake8"
LINTLY_SUPPORT_ARRAY['PYTHON_BLACK']="black"
LINTLY_SUPPORT_ARRAY['PYTHON_PYLINT']="pylint-json"
LINTLY_SUPPORT_ARRAY['JAVASCRIPT_ES']="eslint"
LINTLY_SUPPORT_ARRAY['TYPESCRIPT_ES']="eslint"
LINTLY_SUPPORT_ARRAY['CSS']="stylelint"
LINTLY_SUPPORT_ARRAY['DOCKERFILE_HADOLINT']="hadolint"
LINTLY_SUPPORT_ARRAY['CLOUDFORMATION']="cfn-lint"
export LINTLY_SUPPORT_ARRAY                      # Workaround SC2034

# Not yet implemented by super-linter
# LINTLY_SUPPORT_ARRAY['PYTHON_BANDIT']="bandit-json"
# LINTLY_SUPPORT_ARRAY['ANY']="gitleaks"
# LINTLY_SUPPORT_ARRAY['CLOUDFORMATION_CFNNAG']="cfn-nag"

