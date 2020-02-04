def get_company_list_js(arg):
    arg=str(arg)
    a='return window.document.getElementById("company").querySelectorAll("option")['
    b='].innerText'
    c='].value'
    jscript1=a+arg+b
    jscript2=a+arg+c
    return jscript1,jscript2
    
#print (get_company_list_js('8'))

def get_the_number_of_pages(arg):
    arg=int(arg)
    qoutient=int(arg/10)
    remainder=int(arg%10)
    if remainder==0:
        number_of_pages=qoutient
    else:
        number_of_pages=qoutient+1
    return number_of_pages
    
#print (get_the_number_of_pages('8'))