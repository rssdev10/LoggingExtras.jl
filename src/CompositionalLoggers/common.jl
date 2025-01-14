# Utilities for dealing with compositional loggers.
# Since the logging system itself will not engage its checks
# Once the first logger has started, any compositional logger needs to check
# before passing anything on.

# For checking child logger, need to check both `min_enabled_level` and `shouldlog`
function comp_shouldlog(logger, args...)
    level = first(args)
    min_enabled_level(logger) <= level && shouldlog(logger, args...)
end

# For checking if child logger will take the message you are sending
function comp_handle_message_check(logger, args...; kwargs...)
    level, message, _module, group, id, file, line = args
    return comp_shouldlog(logger, level, _module, group, id)
end