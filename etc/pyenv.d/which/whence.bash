if [ -n "$PYENV_COMMAND" ] && [ ! -x "$PYENV_COMMAND_PATH" ]; then
  versions=($(pyenv-whence "${PYENV_COMMAND}" 2>/dev/null || true))
  localversions=($(pyenv-local | sort -r))
  if [ -n "${versions}" ]; then
    if [ "${#versions[@]}" -gt 1 ]; then
      if [ "${#localversions[@]}" -gt 1 ]; then
        echo "pyenv-implicit: found multiple ${PYENV_COMMAND} in pyenv. Using latest local version ${localversions[0]}." 1>&2
        PYENV_COMMAND_PATH="${PYENV_ROOT}/versions/${localversions[0]}/bin/${PYENV_COMMAND}"
      else
        echo "pyenv-implicit: found multiple ${PYENV_COMMAND} in pyenv. Using version ${versions[0]}." 1>&2
        PYENV_COMMAND_PATH="${PYENV_ROOT}/versions/${versions[0]}/bin/${PYENV_COMMAND}"
      fi
    fi
  fi
fi
