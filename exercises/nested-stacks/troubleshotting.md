gabriel in daws/exercises/nested-stacks on  main [?] 
❯ aws cloudformation package --template-file template-nested.cfn.yml --s3-bucket $BUCKET_NAME --output-template-file package.cfn.yml


Successfully packaged artifacts and wrote output template to file package.cfn.yml.
Execute the following command to deploy the packaged template
aws cloudformation deploy --template-file /home/gabriel/projects/daws/exercises/nested-stacks/package.cfn.yml --stack-name <YOUR STACK NAME>
gabriel in daws/exercises/nested-stacks on  main [?] 
❯ aws cloudformation deploy --stack-name nested-stacks --template-file package.cfn.yml

Waiting for changeset to be created..
Waiting for stack create/update to complete
Successfully created/updated stack - nested-stacks
gabriel in daws/exercises/nested-stacks on  main [?] took 1m 38,4s