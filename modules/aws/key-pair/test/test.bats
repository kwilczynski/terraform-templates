#!/usr/bin/env bats

@test 'Check public-key.sh without any input' {
    run bash -c "echo | bash ../scripts/public-key.sh"
    [[ ${lines[0]} == '{"public_key":""}' ]]
}

@test 'Check public-key.sh empty input' {
    run bash -c "echo | bash ../scripts/public-key.sh"
    [[ ${lines[0]} == '{"public_key":""}' ]]
}

@test 'Check public-key.sh non-existent public key file' {
    run bash -c "echo '{ \"public_key\": \"/nonexistent\" }' | bash ../scripts/public-key.sh"
    [[ ${lines[0]} == '{"public_key":"/nonexistent"}' ]]
}

@test 'Check public-key.sh valid public key file' {
    run bash -c "echo '{ \"public_key\": \"fixtures/id_rsa.pub\" }' | bash ../scripts/public-key.sh"
    [[ ${lines[0]} =~ "ssh-rsa" ]]
}

@test 'Check public-key.sh valid JSON output' {
    run bash -c "echo '{ \"public_key\": \"fixtures/id_rsa.pub\" }' | bash ../scripts/public-key.sh | jq ."
    [[ $status == 0 ]]
}
