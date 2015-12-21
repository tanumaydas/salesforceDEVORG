public class mycontroller {

     public string php {get;set;}



    public mycontroller(ApexPages.StandardController controller) {
        php = '<?php echo "hello world"; ?>';
    }

}