# ClikUpShift



ClickUp is a cloud based project management / ToDo environment. (url: https://clickup.com/?noRedirect=true). 

This Python package adds some functionality that is currently not present. 

It allows you to: 
> * shift tasks (by a number of days),
> * score tasks (by using 4 custom fields), 
> * based on the score give them a priority. 
 

Reference to those custom fields have been hard coded. Therefore, scoring will not work out of the box, shifting tasks should work.

When you add the following fields the code could work, although the field references have been [hard coded](https://github.com/stevedep/ClickUpShiftScore/blob/4b2925c388e3eb26a6fdc039b0eee50dfd79ee0a/ClickUpShiftScore/core.py#L45).
<!--- #![Custom Fields!](images/customfields.png "Custom Fields") --->

<img src="images\customfields.png" alt="drawing" width="700" style="max-width: 700px">



## Install

`pip install ClickUpShiftScore`

## How to use

Load the module and add your API code when you create an instance of `CU`. 


```python
from ClickUpShiftScore.core import *


test = CU("pk_42327425_81VOC277FIDWOA3R8AF8SZ0LH354CP2A")


test.updatetasks("score", 1)
```

    Achter computer of buro
    score updated for: 
    Python webscrape magister
    'value'
    Python Development
    'value'
    Feestje pepijn
    Huis
    'value'
    koffie kalk
    score updated for: 
    Fix hue
    Op pad / Naar Winkel
    Gezinsplanning
    Projecten
    


Please view *[this documentation](https://StevedeP.github.io/ClickUpShiftScore)* to see the documentation for all modules and functions. 


```mermaid
sequenceDiagram
    autonumber
    actor User    
    participant test as test #58; CU
    participant updatetasks as updatetasks #58; test
    participant urlrequest as urlrequest #58; helper 
    participant updatescore as updatescore #58; helper
    participant shiftstartandduedate as shiftstartandduedate #58; helper
    participant updatepriority as updatepriority #58; helper
    User->>test:Init (with API key)
    Note over User, test: User folders stored during init.
    User->>updatetasks: updatetasks("score", 1)
    
    loop folders
        Note over updatetasks, urlrequest: Loop over folders to get the lists
        updatetasks->>urlrequest: urlrequest(folderid)        
        urlrequest->>updatetasks: listdata
        
        loop lists
        Note over updatetasks, urlrequest: Loop over lists to get the tasks
        updatetasks->>urlrequest: urlrequest(listid)
        urlrequest->>updatetasks: taskdata
        Note over updatetasks, updatepriority: for each task in a list one of following options is run [score, shift, priority] 
        autonumber 7
        alt is score
            updatetasks->>updatescore: updatescore(field, task, score)
        autonumber 7
        else is shift
            updatetasks->>shiftstartandduedate: shiftstartandduedate(task, startdate, duedate, dagen, apikey)
        autonumber 7
        else is priority
            updatetasks->>updatepriority: updatepriority(task, score, apikey)
        
            
        end
        
        end
    end
    
```

