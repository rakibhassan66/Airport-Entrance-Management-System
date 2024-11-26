<p align="center">
  <a href="https://git.io/typing-svg">
    <img src="https://readme-typing-svg.herokuapp.com?font=Fira+Code&pause=1000&width=435&lines=Welcome+to+Bangladesh+Airport" alt="Typing SVG">
  </a>
</p>
<a target="_blank" rel="noopener noreferrer nofollow" href="https://raw.githubusercontent.com/rakibhassan66/rakibhassan66/output/github-contribution-grid-snake-dark.svg"><img src="https://raw.githubusercontent.com/ShrekBytes/ShrekBytes/output/github-contribution-grid-snake-dark.svg" alt="Snake animation" style="max-width: 100%;"></a>
### Explanation of the Diagram

- **Entities and Fields**: Each box represents an entity (table) with primary keys (PK) and foreign keys (FK) indicated.
- **Relationships**:
  - **Admin** manages multiple **Users**.
  - **User** has multiple **EntranceLog** entries.
  - **Gate** can have multiple **EntranceLog** entries and is assigned to **Users** based on their role or purpose.
  - **FamilyMember** relates to a **User** as one boarding member per family.
  - **ParcelReceiver** logs specific to parcel gate entries.
  - **ManualTicket** is issued per **User** and linked to a specific **Gate**.
```mermaid
erDiagram
    Admin {
        int AdminID PK
        string Name
        string Email
        string Password
    }

    User {
        int UserID PK
        string Name
        string Occupation
        string AirportID
        int GateNumber
        string IDType
        bool EntranceStatus
        int AdminID FK
    }
    
    Gate {
        int GateID PK
        int GateNumber
        string Location
        string Purpose
        string OccupationType
    }
    
    EntranceLog {
        int LogID PK
        int UserID FK
        int GateID FK
        datetime EntryTime
        datetime ExitTime
        string ReasonForEntry
    }

    FamilyMember {
        int FamilyMemberID PK
        string NID
        string Name
        int BoardingMemberID FK
    }
    
    ParcelReceiver {
        int ReceiverID PK
        string NID
        string Name
        int GateID FK
    }
    
    ManualTicket {
        int TicketID PK
        int GateID FK
        int UserID FK
        datetime IssueTime
    }

    Admin ||--o{ User : "manages"
    User ||--o{ EntranceLog : "logs"
    Gate ||--o{ EntranceLog : "tracks"
    Gate ||--o{ User : "assigned"
    User ||--|{ FamilyMember : "has"
    ParcelReceiver ||--o{ EntranceLog : "logs"
    User ||--o{ ManualTicket : "issued"
    Gate ||--o{ ManualTicket : "linked to"
