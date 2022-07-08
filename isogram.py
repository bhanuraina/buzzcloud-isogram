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

print(check_isogram("six-year----old"))