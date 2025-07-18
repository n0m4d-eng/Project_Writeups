# The Problem

I had an issue with timing myself doing CTF boxes. Being somewhat of an engineer, I decided to find a solution. I spent a day agonizing over scripts that just wouldn't run, and trying to get plugins to evaluate variables replaces by regex.

Finally, I figured out a semi-automated way that works for me. Least for now. 

- Start with getting `Templater` and `Linter` for obsidian.
- Create the following templates for the Templater plugin to use.

<%*

// Get timestamps (auto-updates on open)

const created = new Date(tp.file.creation_date());

const modified = new Date(tp.file.last_modified_date());

const durationMs = modified - created;

// Convert milliseconds to readable format

const seconds = Math.floor((durationMs / 1000) % 60);

const minutes = Math.floor((durationMs / (1000 * 60)) % 60);

const hours = Math.floor((durationMs / (1000 * 60 * 60)) % 24);

const days = Math.floor(durationMs / (1000 * 60 * 60 * 24));

-%>

**Started:** <% tp.file.creation_date("YYYY-MM-DD HH:mm:ss") %>  
**Ended:** <% tp.file.last_modified_date("YYYY-MM-DD HH:mm:ss") %>  
**Time Spent:** <% days %>d <% hours %>h <% minutes %>m <% seconds %>s

- Next we want to use the linter plugin to run custom commands on save, and run regex replace actions as well. 

![](assets/Pasted%20image%2020250716231556.png)

The areas highlighted with red squares get the following code.

```bash
**Ended:** <% tp.file.last_modified_date("YYYY-MM-DD HH:mm:ss") %>  
**Time Spent:** 
**Time Spent:**

const created = new Date(tp.file.creation_date("YYYY-MM-DDTHH:mm:ss"));   
const updated = new Date(tp.file.last_modified_date("YYYY-MM-DDTHH:mm:ss"));   
const diff = updated - created;      
const seconds = Math.floor(diff / 1000) % 60;   
const minutes = Math.floor(diff / (1000 * 60)) % 60;   
const hours = Math.floor(diff / (1000 * 60 * 60)) % 24;   
const days = Math.floor(diff / (1000 * 60 * 60 * 24));      
let duration = [];   
if (days > 0) duration.push(`${days}d`);   
if (hours > 0) duration.push(`${hours}h`);   
if (minutes > 0) duration.push(`${minutes}m`);   
duration.push(`${seconds}s`);      
tR += duration.join(' '); 
```

What happens here is everytime we save a doc, the Linter is going to find and replace the "Ended" and "Time Spent" bits with templater code. At the same time running "Replace templates in file", which uses templater to parse the template code and generate github friendly timestamps.

So yeah, a bit of a workaround, but it gets the job done right now.

# Update

Its funny how you overthink things. 

It would have been easier to just put the whole thing into a separate template file, and add it once when I finished a CTF.