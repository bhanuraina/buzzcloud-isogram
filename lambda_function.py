import json

status="The String is an Isogram."
def lambda_handler(event, context):
    # TODO implement
    
    if check_isogram(event["queryStringParameters"]["string1"]) :
        
        status="The String is an Isogram."
    
    else:
        
        status="The String is not an Isogram."
    
    return {
        'statusCode': 200,
        'body': json.dumps(status)
    }

def check_isogram(str1):
    
    
    if str1.count('-') > 1 :
        print(str1.count('-'))
        str2 = str1.replace('-','')
        print(str2)
        return len(str2) == len(set(str2.lower()))
    elif str1.count(' ') > 1 :
        print(str1.count(' '))
        str2 = str1.replace(' ','')
        print(str2)
        return len(str2) == len(set(str2.lower()))
    else:
        
        return len(str1) == len(set(str1.lower()))

