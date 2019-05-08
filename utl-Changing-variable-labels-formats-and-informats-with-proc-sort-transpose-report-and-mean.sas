Changing variable labels formats and informats with proc sort transpose report and mean                                           
                                                                                                                                  
Variable names have to exist in both input and output                                                                             
                                                                                                                                  
gihub                                                                                                                             
https://tinyurl.com/y46u6v7t                                                                                                      
https://github.com/rogerjdeangelis/utl-Changing-variable-labels-formats-and-informats-with-proc-sort-transpose-report-and-mean    
                                                                                                                                  
*_                   _                                                                                                            
(_)_ __  _ __  _   _| |_                                                                                                          
| | '_ \| '_ \| | | | __|                                                                                                         
| | | | | |_) | |_| | |_                                                                                                          
|_|_| |_| .__/ \__,_|\__|                                                                                                         
        |_|                                                                                                                       
;                                                                                                                                 
                                                                                                                                  
proc format;                                                                                                                      
  value $sex2des                                                                                                                  
    "M" = "Male"                                                                                                                  
    "F" = "Female"                                                                                                                
;run;quit;                                                                                                                        
                                                                                                                                  
                                                                                                                                  
data class(index=(agesex=(age sex)));                                                                                             
 set sashelp.class;                                                                                                               
 format _all_;                                                                                                                    
 informat _all_;                                                                                                                  
run;quit;                                                                                                                         
                                                                                                                                  
 Variables in Creation Order                                                                                                      
                                                                                                                                  
#    Variable    Type    Len                                                                                                      
                                                                                                                                  
1    NAME        Char      8                                                                                                      
2    SEX         Char      1                                                                                                      
3    AGE         Num       8                                                                                                      
4    HEIGHT      Num       8                                                                                                      
5    WEIGHT      Num       8                                                                                                      
                                                                                                                                  
*           _                                                                                                                     
 _ __ _   _| | ___  ___                                                                                                           
| '__| | | | |/ _ \/ __|                                                                                                          
| |  | |_| | |  __/\__ \                                                                                                          
|_|   \__,_|_|\___||___/                                                                                                          
                                                                                                                                  
;                                                                                                                                 
                                                                                                                                  
Apply this attributes to the output dataset from report, transpose, sort and means                                                
                                                                                                                                  
  attrib                                                                                                                          
    name label="Math Student Name" format=$8. informat=$8.                                                                        
    sex  label="Math Student Gender" format=$1. informat=$1.                                                                      
    age  label="Math Student Age in Years" format=3. informat=3.1                                                                 
    weight  label="Math Student Weight in Pounds" format=3. informat=3.1                                                          
    height  label="Math Student Height in Inches" format=3. informat=5.1;                                                         
                                                                                                                                  
*            _               _                                                                                                    
  ___  _   _| |_ _ __  _   _| |_                                                                                                  
 / _ \| | | | __| '_ \| | | | __|                                                                                                 
| (_) | |_| | |_| |_) | |_| | |_                                                                                                  
 \___/ \__,_|\__| .__/ \__,_|\__|                                                                                                 
                |_|                                                                                                               
;                                                                                                                                 
                                                                                                                                  
                            Variables in Creation Order                                                                           
                                                                                                                                  
#    Variable    Type    Len    Format    Informat    Label                                                                       
                                                                                                                                  
1    NAME        Char      8    $8.       $8.         Math Student Name                                                           
2    SEX         Char      1    $SEX2DES. $1.         Math Student Gender                                                         
3    AGE         Num       8    F3.       F3.1        Math Student Age in Years                                                   
4    HEIGHT      Num       8    F3.       F5.1        Math Student Height in Inches                                               
5    WEIGHT      Num       8    F3.       F3.1        Math Student Weight in Pounds                                               
                                                                                                                                  
                                                                                                                                  
*          _       _   _                                                                                                          
 ___  ___ | |_   _| |_(_) ___  _ __  ___                                                                                          
/ __|/ _ \| | | | | __| |/ _ \| '_ \/ __|                                                                                         
\__ \ (_) | | |_| | |_| | (_) | | | \__ \                                                                                         
|___/\___/|_|\__,_|\__|_|\___/|_| |_|___/                                                                                         
                                                                                                                                  
;                                                                                                                                 
                                                                                                                                  
                                                                                                                                  
proc sort data=class out=clsSrt (label="Math Class" sortedby=name index=(name/unique));                                           
  attrib                                                                                                                          
    name label="Math Student Name" format=$8. informat=$8.                                                                        
    sex  label="Math Student Gender" format=$sex2des. informat=$1.                                                                
    age  label="Math Student Age in Years" format=3. informat=3.1                                                                 
    weight  label="Math Student Weight in Pounds" format=3. informat=3.1                                                          
    height  label="Math Student Height in Inches" format=3. informat=5.1;                                                         
  by name;                                                                                                                        
run;quit;                                                                                                                         
                                                                                                                                  
proc report data=class out=clsRpt (drop=_break_);                                                                                 
  attrib                                                                                                                          
    name label="Math Student Name" format=$8. informat=$8.                                                                        
    sex  label="Math Student Gender" format=$sex2des. informat=$1.                                                                
    age  label="Math Student Age in Years" format=3. informat=3.1                                                                 
    weight  label="Math Student Weight in Pounds" format=3. informat=3.1                                                          
    height  label="Math Student Height in Inches" format=3. informat=5.1;                                                         
run;quit;                                                                                                                         
                                                                                                                                  
* only variable names in input and output;                                                                                        
proc transpose data=class out=clsXpo (drop=_:);                                                                                   
   attrib                                                                                                                         
      AGE  label="Age Category" format=3. informat=3.                                                                             
      SEX  label="Gender Category" format=$sex2des. informat=$1.                                                                  
  ;                                                                                                                               
  by age sex;                                                                                                                     
  var name;                                                                                                                       
run;                                                                                                                              
                                                                                                                                  
proc means data=class nway;                                                                                                       
  attrib                                                                                                                          
    sex  label="Math Student Gender" format=$sex2des. informat=$1.                                                                
    age  label="Math Student Age in Years" format=3. informat=3.1                                                                 
    weight  label="Math Student Weight in Pounds" format=3. informat=3.1                                                          
    height  label="Math Student Height in Inches" format=3. informat=5.1;                                                         
class sex;                                                                                                                        
var age height weight;                                                                                                            
output out=clsAvg (drop=_:) mean=;                                                                                                
run;                                                                                                                              
                                                                                                                                  
                                                                                                                                  
