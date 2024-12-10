-- Main Schema for Airport Management System

-- Table: Airlines
CREATE TABLE Airlines (
    AirlineID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Country VARCHAR(100),
    ContactInfo VARCHAR(255)
);

-- Table: Flights
CREATE TABLE Flights (
    FlightID INT PRIMARY KEY AUTO_INCREMENT,
    FlightNumber VARCHAR(10) NOT NULL,
    AirlineID INT NOT NULL,
    Source VARCHAR(100),
    Destination VARCHAR(100),
    DepartureTime DATETIME,
    ArrivalTime DATETIME,
    Status ENUM('Scheduled', 'Delayed', 'Cancelled', 'Completed'),
    FOREIGN KEY (AirlineID) REFERENCES Airlines(AirlineID)
);

-- Table: Passengers
CREATE TABLE Passengers (
    PassengerID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DateOfBirth DATE,
    PassportNumber VARCHAR(20),
    Nationality VARCHAR(50),
    ContactInfo VARCHAR(255)
);

-- Table: Tickets
CREATE TABLE Tickets (
    TicketID INT PRIMARY KEY AUTO_INCREMENT,
    FlightID INT NOT NULL,
    PassengerID INT NOT NULL,
    SeatNumber VARCHAR(5),
    Class ENUM('Economy', 'Business', 'First'),
    BookingStatus ENUM('Confirmed', 'Cancelled'),
    FOREIGN KEY (FlightID) REFERENCES Flights(FlightID),
    FOREIGN KEY (PassengerID) REFERENCES Passengers(PassengerID)
);

-- Table: Employees
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100),
    Role VARCHAR(50),
    Department VARCHAR(50),
    ContactInfo VARCHAR(255),
    Salary DECIMAL(10, 2)
);

-- Table: Gates
CREATE TABLE Gates (
    GateID INT PRIMARY KEY AUTO_INCREMENT,
    TerminalID INT NOT NULL,
    GateNumber VARCHAR(10),
    Status ENUM('Available', 'Occupied', 'Maintenance'),
    FOREIGN KEY (TerminalID) REFERENCES Terminals(TerminalID)
);

-- Table: Terminals
CREATE TABLE Terminals (
    TerminalID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(50),
    Capacity INT,
    Status ENUM('Operational', 'Under Maintenance')
);

-- Table: Runways
CREATE TABLE Runways (
    RunwayID INT PRIMARY KEY AUTO_INCREMENT,
    RunwayNumber VARCHAR(10),
    Status ENUM('Available', 'Occupied', 'Maintenance')
);

-- Table: MaintenanceSchedule
CREATE TABLE MaintenanceSchedule (
    MaintenanceID INT PRIMARY KEY AUTO_INCREMENT,
    Type ENUM('Runway', 'Aircraft', 'Gate'),
    Description TEXT,
    ScheduledDate DATE,
    EmployeeID INT,
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

-- Table: Baggage
CREATE TABLE Baggage (
    BaggageID INT PRIMARY KEY AUTO_INCREMENT,
    PassengerID INT NOT NULL,
    FlightID INT NOT NULL,
    Status ENUM('Checked In', 'In Transit', 'Delivered'),
    FOREIGN KEY (PassengerID) REFERENCES Passengers(PassengerID),
    FOREIGN KEY (FlightID) REFERENCES Flights(FlightID)
);

-- Table: SecurityCheckpoints
CREATE TABLE SecurityCheckpoints (
    CheckpointID INT PRIMARY KEY AUTO_INCREMENT,
    Location VARCHAR(50),
    GateID INT,
    Status ENUM('Active', 'Inactive'),
    FOREIGN KEY (GateID) REFERENCES Gates(GateID)
);

-- Table: FuelStations
CREATE TABLE FuelStations (
    FuelStationID INT PRIMARY KEY AUTO_INCREMENT,
    Location VARCHAR(50),
    Capacity DECIMAL(10, 2),
    FlightID INT,
    FOREIGN KEY (FlightID) REFERENCES Flights(FlightID)
);

-- Table: WeatherInfo
CREATE TABLE WeatherInfo (
    WeatherID INT PRIMARY KEY AUTO_INCREMENT,
    Date DATE,
    Time TIME,
    Conditions ENUM('Sunny', 'Rainy', 'Stormy', 'Cloudy'),
    RunwayID INT,
    FOREIGN KEY (RunwayID) REFERENCES Runways(RunwayID)
);

-- Table: Immigration
CREATE TABLE Immigration (
    ImmigrationID INT PRIMARY KEY AUTO_INCREMENT,
    PassengerID INT NOT NULL,
    FlightID INT NOT NULL,
    Status ENUM('Approved', 'Pending'),
    FOREIGN KEY (PassengerID) REFERENCES Passengers(PassengerID),
    FOREIGN KEY (FlightID) REFERENCES Flights(FlightID)
);

-- Table: AirlineStaff
CREATE TABLE AirlineStaff (
    StaffID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100),
    Role VARCHAR(50),
    AirlineID INT NOT NULL,
    ContactInfo VARCHAR(255),
    FOREIGN KEY (AirlineID) REFERENCES Airlines(AirlineID)
);

-- Table: VIPLounge
CREATE TABLE VIPLounge (
    LoungeID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(50),
    Capacity INT,
    Status ENUM('Open', 'Closed')
);

-- Table: Cargo
CREATE TABLE Cargo (
    CargoID INT PRIMARY KEY AUTO_INCREMENT,
    Weight DECIMAL(10, 2),
    FlightID INT,
    Status ENUM('Loaded', 'Unloaded', 'In Transit'),
    FOREIGN KEY (FlightID) REFERENCES Flights(FlightID)
);

-- Table: TaxiService
CREATE TABLE TaxiService (
    TaxiID INT PRIMARY KEY AUTO_INCREMENT,
    DriverName VARCHAR(100),
    LicenseNo VARCHAR(50),
    PassengerID INT,
    FOREIGN KEY (PassengerID) REFERENCES Passengers(PassengerID)
);

-- Table: LostAndFound
CREATE TABLE LostAndFound (
    ItemID INT PRIMARY KEY AUTO_INCREMENT,
    Description TEXT,
    FoundDate DATE,
    OwnerPassengerID INT,
    FOREIGN KEY (OwnerPassengerID) REFERENCES Passengers(PassengerID)
);

-- Table: DutyFreeShop
CREATE TABLE DutyFreeShop (
    PurchaseID INT PRIMARY KEY AUTO_INCREMENT,
    PassengerID INT,
    ItemName VARCHAR(50),
    Price DECIMAL(10, 2),
    FOREIGN KEY (PassengerID) REFERENCES Passengers(PassengerID)
);

-- Table: EmergencyContacts
CREATE TABLE EmergencyContacts (
    ContactID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100),
    Relation VARCHAR(50),
    Phone VARCHAR(20),
    PassengerID INT,
    FOREIGN KEY (PassengerID) REFERENCES Passengers(PassengerID)
);

-- Table: ParkingLot
CREATE TABLE ParkingLot (
    ParkingID INT PRIMARY KEY AUTO_INCREMENT,
    Location VARCHAR(50),
    Capacity INT,
    Status ENUM('Available', 'Full')
);

-- Table: HotelReservations
CREATE TABLE HotelReservations (
    ReservationID INT PRIMARY KEY AUTO_INCREMENT,
    HotelName VARCHAR(100),
    CheckInDate DATE,
    CheckOutDate DATE,
    PassengerID INT,
    FOREIGN KEY (PassengerID) REFERENCES Passengers(PassengerID)
);

-- Table: FlightCrewSchedule
CREATE TABLE FlightCrewSchedule (
    ScheduleID INT PRIMARY KEY AUTO_INCREMENT,
    CrewMemberID INT,
    FlightID INT,
    Role ENUM('Pilot', 'Co-Pilot', 'Cabin Crew'),
    FOREIGN KEY (FlightID) REFERENCES Flights(FlightID)
);

-- Table: EmergencyProtocol
CREATE TABLE EmergencyProtocol (
    ProtocolID INT PRIMARY KEY AUTO_INCREMENT,
    Type ENUM('Fire', 'Medical', 'Security'),
    Description TEXT,
    ResponsibleEmployeeID INT,
    FOREIGN KEY (ResponsibleEmployeeID) REFERENCES Employees(EmployeeID)
);

-- Table: RetailStores
CREATE TABLE RetailStores (
    StoreID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100),
    Location VARCHAR(50)
);

-- New Table: FlightStatusLog
CREATE TABLE FlightStatusLog (
    LogID INT PRIMARY KEY AUTO_INCREMENT,
    FlightID INT NOT NULL,
    OldStatus ENUM('Scheduled', 'Delayed', 'Cancelled', 'Completed'),
    NewStatus ENUM('Scheduled', 'Delayed', 'Cancelled', 'Completed'),
    ChangeTime DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (FlightID) REFERENCES Flights(FlightID)
);

-- Trigger: Log Flight Status Changes
DELIMITER $$

CREATE TRIGGER LogFlightStatusChange
AFTER UPDATE ON Flights
FOR EACH ROW
BEGIN
    -- Check if the status has changed
    IF OLD.Status <> NEW.Status THEN
        INSERT INTO FlightStatusLog (FlightID, OldStatus, NewStatus)
        VALUES (NEW.FlightID, OLD.Status, NEW.Status);
    END IF;
END$$

DELIMITER ;
