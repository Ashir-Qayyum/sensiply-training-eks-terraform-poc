#### FIRST, I generated .json report with the followig:   (I have put all the .json files in .gitignore as they contain sensitive data)

FOR CONFIG SCANING:<br>

> trivy config ../terraform \
> --format json \
> -o config-scan-report.json

FOR PLAN SCAN:<br>

First i generated fresh tfplan running at dir terraform/:<br>
> terraform plan -out=tfplan                                (I later included tfplan and its json in .gitignore) <br>
<br>Then I coverted the genrated tfplan to json with:<br>
> terraform show -json tfplan > tfplan.json                 (tfplan.json in .gitignore)<br>

Then I moved to dir Trivy/ and generated report with:<br>
> trivy config ../terraform/tfplan.json \
> --format json \
> -o plan-scan-report.json

FOR STATE SCAN:<br>

First I temporarily pulled the remote-backend to local at dir terraform/ running:      (LATER I have deleted it even from my local also)<br>
> terraform state pull > terraform.tfstate

then moving at the dir Trivy/ I ran:<br>
> trivy config ../terraform/terraform.tfstate \
> --format json \
> -o state-scan-report.json<br>
( The Scan went successful and trivy found no misconfiguration/vulnerablility in the Deployed Infra so returned minimal json file)

#### FINALLY, I GENERATED READABLE HTML FILES FOR THE REPORTS

First, I downloaded the template running:<br>
(at dir Trivy/)<br>
> mkdir -p contrib
> curl -L https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/html.tpl \
> -o contrib/html.tpl

Then generated html reports:<br>

FOR CONFIG SCAN:<br>
> trivy convert \
> --format template \
> --template "@contrib/html.tpl" \
> --output config-scan-report.html \
> config-scan-report.json

FOR PLAN SCAN:<br>
> trivy convert \
> --format template \
> --template "@contrib/html.tpl" \
> --output plan-scan-report.html \
> plan-scan-report.json

FOR STATE SCAN:<br>         
( The Scan went successful and trivy found no misconfiguration/vulnerablility in the Deployed Infra so returned empty )<br>
> trivy convert \
> --format template \
> --template "@contrib/html.tpl" \
> --output state-scan-report.html \
> state-scan-report.json