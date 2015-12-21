Global class testremotecontroller {


public testremotecontroller ()
{}

@remoteAction
Global static void testremote(string id)
{

  account a = [select name from account where id =: id];
  a.name += 'done';
  update a;

}


}