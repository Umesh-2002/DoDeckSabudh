# ###DoDeckSabudh

###  Key Features

- **Task Lifecycle Management**
  - Create tasks with title, description, due date, start/end times  
  - Edit or remove existing tasks

- **Automatic Categorization**
  - **Overdue**: tasks past their end time and not completed  
  - **Not Started**: tasks not yet marked in progress  
  - **In Progress**: tasks marked as started  
  - **Completed**: tasks finished by the user

- **Smart Completion Rules**
  - Only tasks in “In Progress” can be marked complete  
  - Once **Completed**, a task never moves back to **Overdue**, even if its due time passes

- **Theme Switching**
  - Toggle between **Light** and **Dark** modes from the app bar


### Data Models
**File: lib/models/task.dart**

  String id;               // Unique identifier (UUID)
  String title;            // Short summary
  String description;      // Detailed notes
  DateTime dueDate;        // Calendar due date
  TimeOfDay startTime;     // Scheduled start
  TimeOfDay endTime;       // Scheduled end
  bool isCompleted;        // true if task marked done
  String status;           // “Not Started”, “In Progress”, “Completed”

  Task({ /* required fields + defaults */ });

  Map<String, dynamic> toMap() { /* convert to key/value pairs */ }
  factory Task.fromMap(Map<String, dynamic> map) { /* restore from DB */ }
}

**toMap():** prepares data for SQLite (dates → strings, times → hour/minute ints, booleans as 0/1)

**fromMap():** converts raw database rows back into Task objects

###  Storage Layer
**File: lib/services/db_helper.dart**

A singleton class that wraps all SQLite operations via the sqflite plugin.
table creation for data storage :
CREATE TABLE tasks (
  id TEXT PRIMARY KEY,
  title TEXT,
  description TEXT,
  dueDate TEXT,
  startHour INTEGER,
  startMinute INTEGER,
  endHour INTEGER,
  endMinute INTEGER,
  isCompleted INTEGER,
  status TEXT
)

## CRUD methods:

**insertTask(Task t)** – Inserts or overwrites using ConflictAlgorithm.replace

**fetchTasks()** – Loads all rows, maps each to Task.fromMap

**updateTask(Task t)** – Updates a single row by matching id

**deleteTask(String id)** – Removes a task from the table

Centralizes SQL so the rest of the app stays pure Dart.





