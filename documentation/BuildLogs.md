
# Where are the logs?

The logs are stored under `$ROOT/logs` and are generated on each build session.
The format of the logs is as follows:
`{builder_script_name}.{fd_number}.{exit_code}`

NOTE: Everything enclosed in `{}` is a description of the actual value.
ATTENTION: exit_code will not be present until the builder script
actually completes.

# Why is it like that?

To allow faster building we introduced parallelism but that
made it hard to diagnose problems with builder scripts.

To tackle both, performance and debugging, problems at once we introduced the
`$ROOT/logrun.sh` builder script launcher.
This launcher accepts the builder script as it's only parameter.
The output of the script is piped to the respective logfile.
After the script completes the launcher adds the exit code to the logfile.
