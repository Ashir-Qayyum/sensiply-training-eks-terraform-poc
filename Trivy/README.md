
## FIRST, I generated .json report with the followig:   (I have put all these .json in .gitignore as they contain sensitive data)

FOR CONFIG SCANING:
trivy config ../terraform \
--format json \
-o config-scan-report.json

FOR PLAN SCAN:
First i generated fresh tfplan at terraform/ with: terraform plan -out=tfplan   (I later included tfplan and its json in .gitignore)

Then I coverted the genrated tfplan to json with:
terraform show -json tfplan > tfplan.json                 (tfplan.json in .gitignore)

Then I moved to Trivy/ and generated report with:
trivy config ../terraform/tfplan.json \
--format json \
-o plan-scan-report.json

FOR STATE SCAN:
First I temporarily pulled the remote-backend to local at terraform/ with:      (THEN I have deleted it even from my local also)
terraform state pull > terraform.tfstate

then moving at the Trivy/ I ran:
trivy config ../terraform/terraform.tfstate \
--format json \
-o state-scan-report.json
( The Scan went successful and trivy found no misconfiguration/vulnerablility in the Deployed Infra so returned minimal json file)

## FINALLY, I GENERATED READABLE HTML FILES FOR THE REPORTS

First, I downloaded the template with:
(at Trivy/)
mkdir -p contrib
curl -L https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/html.tpl \
-o contrib/html.tpl

Then generated html reports:

FOR CONFIG SCAN:
trivy convert \
--format template \
--template "@contrib/html.tpl" \
--output config-scan-report.html \
config-scan-report.json

FOR PLAN SCAN:
trivy convert \
--format template \
--template "@contrib/html.tpl" \
--output plan-scan-report.html \
plan-scan-report.json

FOR STATE SCAN:         
( The Scan went successful and trivy found no misconfiguration/vulnerablility in the Deployed Infra so returned empty )
trivy convert \
--format template \
--template "@contrib/html.tpl" \
--output state-scan-report.html \
state-scan-report.json