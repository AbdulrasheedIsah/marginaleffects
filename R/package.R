# https://stackoverflow.com/questions/9439256/how-can-i-handle-r-cmd-check-no-visible-binding-for-global-variable-notes-when#comment20826625_12429344
# 2012 hadley says "globalVariables is a hideous hack and I will never use it"
# 2014 hadley updates his own answer with globalVariables as one of "two solutions"
utils::globalVariables(c('.', 'term', 'part', 'estimate', 'conf.high',
                         'conf.low', 'value', 'p.value', 'std.error',
                         'statistic', 'stars_note', 'logLik', 'formatBicLL',
                         'section', 'position', 'where', 'ticks', 'statistic1',
                         'model', 'tmp_grp', 'condition_variable', 'conf_int',
                         'conf_level', 'group', 'contrast', 'm', 'dydx',
                         'rowid', 'predicted', 'gn'))
