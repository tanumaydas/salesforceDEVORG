public class nameCheckController {

public nameCheckController ()
{}



@remoteAction
public static string check(string name)
{
    list<account> alist = [select name from account where name =: name];
    if(alist.size()>0)
     return '1';
     
     return '0';

}

}