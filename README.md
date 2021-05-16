# glacier_national_park
Simple script to get glacier national park lodges availability in a given month.

# Usage
`chmod u+x glacier_national_park.sh`

`./glacier_national_park <START_DAY> <MONTH> <END_DAY> <AWS_PROFILE> <SNS_ARN>`

`START_DAY` - day to start the search

`MONTH` - Month you want to search 

`END_DAY` - day to end the search

### Optional parameters 
If you want the script to text you the availability then you will have to setup a sns topic in aws and subscribe your phone number to it. 
Provide the aws profile and sns arn as input to the script. 

`AWS_PROFILE` - profile to use in the aws cli. See https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-profiles.html for more information on setting up aws profile for cli operations. 

`SNS_ARN` - ARN of the sns topic to which you have subscribed your number for updates. 
* Create a simple sns topic of type `Standard` and give it a name ex: gnp_updates. Leave everything else to default setup or update as you see fit. 
* Under the created the SNS topic, create a new Subscription.
** Select the protocol as `SMS` and provide your number.  
* copy the SNS topic's ARN and provide it as the input for the script. 

`./glacier_national_park 1 8 30` - will fetch lodge availability from 08/01/2021 to 08/30/2021. 

```
GLLM	- Lake McDonald Lodge
GLMG	- Many Glacier Hote
GLRS	- Rising Sun Motor Inn & Cabins
GLSC	- Swiftcurrent Motor Inn & Cabins
GLVI	- Village Inn at Apgar
GLCC	- Cedar Creek Lodge (Columbia Falls, MT)
```
