!SLIDE subsectionnonum
# WebGUI

!SLIDE smbullets small
# Searches

* Almost all views are simple lists
* Some views like "Reports" have a default filter
* Most views provide additional searches
* Bookmark and share your own search

<div style="text-align:right">
<img src="./_images/foreman-searches.png" style="float: right, max-width:200px; max-height: 250px; width: auto; height: auto; margin-top: 50px; margin-right: 290px" alt="Foreman Searches"/>
</div>

~~~SECTION:handouts~~~

****

~~~PAGEBREAK~~~

In the Foreman WebGUI almost all views are simple unfiltered lists, some views like the "Reports" view are filtered by
default using a search and most provide additional searches to quickly filter for typically views like 'all hosts
out of sync'. But the WebGUI is not limited to these searches you can always create your own and bookmark it for later.
Setting a bookmark to public allows to share it with other users.

The search field can be used for a free text search but gets more powerful if using the autosuggestions. It provides
different comparison operators depending on the type of the field compared including SQL like wildcard matching.

For more details see: http://theforeman.org/manuals/latest/index.html#4.1.5Searching

~~~ENDSECTION~~~

!SLIDE smbullets small
# Trends

* Graphs changes in your enviroment
* Configured in the WebGUI and collected by a cronjob
* Internal Host parameters or Facts provided by Configuration Management

<div style="text-align:right">
<img src="./_images/foreman-trend-puppetversion.png" style="float: right, max-width:200px; max-height: 300px; width: auto; height: auto; margin-top: 50px; margin-right: 260px" alt="Foreman Trends"/>
</div>

~~~SECTION:handouts~~~

****

<br/>
Foreman can provide graphs about changes in your environment. Those are configured and displayed in the WebGUI in
"Monitor > Trends" and a cronjob is performs the data collection. By default this cronjob runs every 30 minutes matching 
Puppet's default run interval because most trends will be based on the facts collected by the configuration management
solution, another source are Foreman's internal parameters like the operatingsystem of the host.

~~~ENDSECTION~~~
