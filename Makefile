PROJECT = chronos

DEPS = edown gen_leader gproc

dep_gproc = git://github.com/uwiger/gproc 0.6
dep_edown = https://github.com/uwiger/edown master
dep_gen_leader = https://github.com/abecciu/gen_leader_revival.git master


TEST_DEPS = meck

dep_meck = git://github.com/eproxus/meck 0.8.4

CT_SUITES = chronos

include erlang.mk

test_chronos: ERLC_OPTS := $(filter-out -Werror,$(ERLC_OPTS))

example_beams: examples/*.erl

examples: app example_beams
	erlc -o examples examples/*.erl


ex-shell: examples
	erl -pz examples -pz deps/*/ebin -pz ebin

clean-beam:
	rm -rf ebin/*.beam examples/*.beam test/*.beam


clean-ct:
	rm -rf ct_run*
	-rm -f all_runs.html
	-rm -f index.html
	-rm -f jquery*.js
	-rm -f ct_default.css
	-rm -f variables-ct*

deep-clean: clean-beam clean-ct
	rm -rf deps
