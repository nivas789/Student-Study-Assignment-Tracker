# SAP Student Study and Assignment Tracker

A SAP ABAP and OData-based Student Study and Assignment Tracker designed to manage student assignments, track completion status, monitor deadlines, and display study statistics.

The project demonstrates SAP ABAP development, database table handling, report programming, ALV-style output, and SAP Gateway OData service development.

---

## Project Overview

The **Student Study and Assignment Tracker** allows student assignment information to be maintained in SAP and displayed through an ABAP report.

The system provides:

* Assignment tracking
* Completed and pending assignment monitoring
* Deadline/status tracking
* Study-hour tracking
* Completion percentage calculation
* Filtering using selection options
* Structured report output
* OData service integration for future web/UI access

---

## Project Architecture

```text
                 STUDENT STUDY & ASSIGNMENT TRACKER
                              |
                              v
                     ZSTUDENT_TRACKER
                      Database Table
                              |
                              v
                    ABAP Report Program
                              |
                 +------------+------------+
                 |            |            |
               ALL        PENDING      COMPLETED
                 |            |            |
                 +------------+------------+
                              |
                              v
                    Assignment Report
                              |
                              v
                     OData Service
                              |
                              v
                 ZSTUDENT_TRACKER_SRV
                              |
                              v
                  StudentAssignmentSet
                              |
                              v
                       Future Web UI
```

---

## Technologies Used

* SAP ABAP
* SAP GUI
* ABAP Dictionary
* ALV / Structured Report Output
* SAP Gateway
* OData
* SEGW (SAP Gateway Service Builder)
* SAP Gateway Client
* Eclipse / ABAP Development Tools

---

## Main Features

### 1. Assignment Tracking

The application stores student assignment information in a custom SAP database table.

### 2. Assignment Filtering

The report provides selection options for:

```text
P_ALL
P_PEND
P_COMP
P_OVER
```

These options allow the user to display different assignment categories.

### 3. Assignment Statistics

The report calculates and displays information such as:

```text
Total Assignments
Completed
Pending
Completion Percentage
Total Study Hours
```

### 4. Assignment Details

The report displays assignment information including:

```text
ID
Subject
Assignment
Deadline
Status
```

### 5. OData Integration

The assignment data is exposed through an SAP Gateway OData service.

---

# SAP Objects

## Database Table

```text
ZSTUDENT_TRACKER
```

The custom database table stores the student assignment information used by the application.

---

## ABAP Report

```text
ZSTUDENT_TRACKER_REPORT
```

The ABAP report retrieves assignment data, processes the information, calculates statistics, and displays the result to the user.

---

## OData Service

```text
ZSTUDENT_TRACKER_SRV
```

The OData service exposes the student assignment data for external consumers and future UI integration.

---

## Entity Type

```text
StudentAssignment
```

---

## Entity Set

```text
StudentAssignmentSet
```

---

# OData Operations

The following OData operations have been implemented.

## GET_ENTITYSET

Retrieves multiple student assignment records.

```http
GET /sap/opu/odata/sap/ZSTUDENT_TRACKER_SRV/StudentAssignmentSet
```

---

## GET_ENTITY

Retrieves a specific student assignment record using its key.

```http
GET /sap/opu/odata/sap/ZSTUDENT_TRACKER_SRV/StudentAssignmentSet(<KEY>)
```

---

## CREATE_ENTITY

Creates a new student assignment record through the OData service.

```http
POST /sap/opu/odata/sap/ZSTUDENT_TRACKER_SRV/StudentAssignmentSet
```

When testing POST requests, SAP Gateway CSRF protection must be handled appropriately.

---

# Report Selection Screen

The report provides four selection options:

| Option   | Purpose                       |
| -------- | ----------------------------- |
| `P_ALL`  | Display all assignments       |
| `P_PEND` | Display pending assignments   |
| `P_COMP` | Display completed assignments |
| `P_OVER` | Display overdue assignments   |

---

# Report Output

The report displays a student assignment summary similar to:

```text
STUDENT STUDY & ASSIGNMENT TRACKER

Total Assignments : 3
Completed         : 2
Pending           : 1
Completion        : 67 %
Total Study Hours : 9.00
```

Assignment details include:

```text
ID        SUBJECT     ASSIGNMENT       DEADLINE       STATUS
000001    DBMS        DBMS ASSIGNMENT  22.08.2026     COMPLETED
000002    JAVA        JAVA ASSIGNMENT  22.08.2026     COMPLETED
000003    OS          OS ASSIGNMENT    23.08.2026     DUE TODAY
```

---

# OData Service Structure

```text
ZSTUDENT_TRACKER_SRV
│
├── StudentAssignment
│
└── StudentAssignmentSet
       │
       ├── GET_ENTITYSET
       ├── GET_ENTITY
       └── CREATE_ENTITY
```

---

# Development Process

## Step 1 – Database Table

Created the custom database table:

```text
ZSTUDENT_TRACKER
```

The table stores the assignment-related data.

## Step 2 – ABAP Report

Created the report:

```text
ZSTUDENT_TRACKER_REPORT
```

The report retrieves and processes assignment information.

## Step 3 – Selection Screen

Added selection options:

```text
P_ALL
P_PEND
P_COMP
P_OVER
```

## Step 4 – Assignment Processing

The report processes assignment records and calculates:

* Total assignments
* Completed assignments
* Pending assignments
* Completion percentage
* Total study hours

## Step 5 – Report Output

Created a structured report displaying the assignment summary and individual assignment records.

## Step 6 – SEGW Project

Created an SAP Gateway Service Builder project for exposing assignment information through OData.

## Step 7 – Entity Type

Created:

```text
StudentAssignment
```

## Step 8 – Entity Set

Created:

```text
StudentAssignmentSet
```

## Step 9 – OData Service

Generated and activated:

```text
ZSTUDENT_TRACKER_SRV
```

## Step 10 – OData Implementation

Implemented the required Data Provider Extension methods:

```text
GET_ENTITYSET
GET_ENTITY
CREATE_ENTITY
```

## Step 11 – Service Testing

Tested the OData service using SAP Gateway tools.

---

# OData Service URLs

### Service Root

```text
/sap/opu/odata/sap/ZSTUDENT_TRACKER_SRV/
```

### Metadata

```text
/sap/opu/odata/sap/ZSTUDENT_TRACKER_SRV/$metadata
```

### Entity Set

```text
/sap/opu/odata/sap/ZSTUDENT_TRACKER_SRV/StudentAssignmentSet
```

> The complete URL depends on the SAP system/server configuration.

---

# Repository Structure

```text
SAP-Student-Assignment-Tracker/
│
├── README.md
│
├── ABAP/
│   ├── ZSTUDENT_TRACKER/
│   │   ├── ZSTUDENT_TRACKER.abap
│   │   └── table-structure.txt
│   │
│   └── Reports/
│       └── ZSTUDENT_TRACKER_REPORT.abap
│
├── OData/
│   ├── ZSTUDENT_TRACKER_SRV/
│   │   ├── DPC_EXT/
│   │   │   ├── GET_ENTITYSET.abap
│   │   │   ├── GET_ENTITY.abap
│   │   │   └── CREATE_ENTITY.abap
│   │   │
│   │   ├── MPC_EXT/
│   │   │   └── metadata.txt
│   │   │
│   │   └── service-details.txt
│   │
│   └── API-Testing/
│       └── sample-requests.txt
│
├── Screenshots/1,2,3,4,5
│
└── UI/
    └── README.md
```

---

# Screenshots

The project screenshots demonstrate the major stages of development:

1. Selection screen
2. Student assignment report output
3. SEGW project
4. Entity Type
5. Entity Set
6. GET_ENTITYSET implementation
7. GET_ENTITY implementation
8. CREATE_ENTITY implementation
9. OData service testing

---

# Current Project Status

| Component             | Status               |
| --------------------- | -------------------- |
| Database Table        | ✅ Completed          |
| ABAP Report           | ✅ Completed          |
| Selection Screen      | ✅ Completed          |
| Assignment Processing | ✅ Completed          |
| Report Output         | ✅ Completed          |
| SEGW Project          | ✅ Completed          |
| Entity Type           | ✅ Completed          |
| Entity Set            | ✅ Completed          |
| OData Service         | ✅ Completed          |
| GET_ENTITYSET         | ✅ Completed          |
| GET_ENTITY            | ✅ Completed          |
| CREATE_ENTITY         | ✅ Implemented        |
| OData Testing         | 🔄 Testing           |
| Web UI                | 🔄 Under Development |

---

# Future Enhancements

The next phase of the project can include:

* Web-based student dashboard
* Assignment creation form
* Assignment editing
* Assignment deletion
* Search functionality
* Assignment filtering
* Due-date highlighting
* Study-hour visualization
* Responsive UI
* Complete OData CRUD integration
* Frontend-to-SAP backend integration

---

# Learning Outcomes

This project provided practical experience in:

* SAP ABAP programming
* ABAP Dictionary
* Custom database table creation
* Report development
* Selection screens
* Data processing and calculations
* ALV/structured report output
* SAP Gateway
* SEGW
* OData service development
* Entity Type and Entity Set creation
* Data Provider Extension implementation
* OData service testing
* Backend and frontend integration concepts

---
**Project:** SAP Student Study and Assignment Tracker

---

## Project Status

The SAP ABAP and OData backend implementation has been developed successfully. The web UI and further frontend integration are planned as the next phase of development.
