# ClikUpShift
> Package that allows you to shift tasks and to score them. Scoring does require custom fields. Reference to those custom fields have been hard coded. Therefore, scoring will not work out of the box, shifting tasks should work.


## Install

`pip install ClickUpShift`

## How to use

Load the module and add your API code when you create an instance of `CU`. 


```python
from ClickUpShift.core import *


test = CU("pk_42327425_NPYWMF9GG6AQY7OZF36QRXL8XXXS65J7")


test.updatetasks("score", 1)
```

```python
from pkg_resources import parse_version
from configparser import ConfigParser

# note: all settings are in settings.ini; edit there, not here
config = ConfigParser(delimiters=['='])
config.read('settings.ini')
cfg = config['DEFAULT']

name = cfg['lib_name']
user = cfg['user']


from IPython.display import display, Markdown, Latex
display(Markdown('Please view *[this documentation](https://github.com/' + user + '/' + name + ')* to see the documentation for all modules and functions. '  ))

```


Please view *[this documentation](https://github.com/StevedeP/ClickUpShiftScore)* to see the documentation for all modules and functions. 


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

