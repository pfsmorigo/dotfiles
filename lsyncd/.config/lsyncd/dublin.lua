settings {
	logfile    = "/tmp/lsyncd_dublin.log",
	statusFile = "/tmp/lsyncd_dublin.status",
	nodaemon   = false,
}

sync {
	default.rsync,
	source = "/home/pfsmorigo",
	target = "/mnt/disk/manaus-home/pfsmorigo",
	exclude = { '~/Private' },

	collect = function(agent, exitcode)
		local config = agent.config
		local rc = config.exitcodes and config.exitcodes[exitcode]

		if rc == "die" then
			return rc
		end

		if agent.isList then
			if rc == "again" then
				log("Normal", "XXX Retrying a list on exitcode = ",exitcode)
			else
				log("Normal", "XXX Finished a list = ",exitcode)
				--spawnShell('[[ /usr/bin/echo "$1" > /tmp/fil ]]', event.sourceName)
			end
		else
			if rc == "again" then
				log("Normal", "XXX Retrying ",agent.etype,
				" on ",agent.sourcePath," = ",exitcode)
			else
				log("Normal", "XXX Finished ",agent.etype,
				" on ",agent.sourcePath," = ",exitcode)
			end
		end
		return rc
	end,
}
