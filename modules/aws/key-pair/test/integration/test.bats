#!/usr/bin/env bats

@test 'Check key-pair test_1 key_name' {
    run bash -c "terraform output | grep test_1_key_name"
    [[ ${lines[0]} =~ "test_1-key-pair" ]]
}

@test 'Check key-pair test_1 algorithm' {
    run bash -c "terraform output | grep test_1_algorithm"
    [[ ${lines[0]} =~ "RSA" ]]
}

@test 'Check key-pair test_1 fingerprint' {
    run bash -c "terraform output | grep test_1_fingerprint"
    [[ ${lines[0]} =~ [a-z0-9:]* ]]
}

@test 'Check key-pair test_2 key_name' {
    run bash -c "terraform output | grep test_2_key_name"
    [[ ${lines[0]} =~ "key_pair_test_2" ]]
}

@test 'Check key-pair test_2 algorithm' {
    run bash -c "terraform output | grep test_2_algorithm"
    [[ $status == 1 ]]
}

@test 'Check key-pair test_2 fingerprint' {
    run bash -c "terraform output | grep test_2_fingerprint"
    [[ ${lines[0]} =~ "7d:e0:81:e3:92:cc:79:81:6a:c3:37:03:aa:79:46:98" ]]
}
