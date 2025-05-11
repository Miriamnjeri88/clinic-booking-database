-- Clinic Booking System Schema

-- Patients Table
CREATE TABLE Patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    dob DATE NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15) NOT NULL
);

-- Doctors Table
CREATE TABLE Doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15) NOT NULL
);

-- Specializations Table
CREATE TABLE Specializations (
    specialization_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL
);

-- Junction Table for Many-to-Many: Doctors <-> Specializations
CREATE TABLE DoctorSpecializations (
    doctor_id INT,
    specialization_id INT,
    PRIMARY KEY (doctor_id, specialization_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id),
    FOREIGN KEY (specialization_id) REFERENCES Specializations(specialization_id)
);

-- Appointments Table
CREATE TABLE Appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATETIME NOT NULL,
    reason TEXT,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);

-- Prescriptions Table (1:1 with Appointment)
CREATE TABLE Prescriptions (
    prescription_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT UNIQUE NOT NULL,
    medication TEXT NOT NULL,
    dosage TEXT,
    instructions TEXT,
    FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id)
);

-- Medical Records Table
CREATE TABLE MedicalRecords (
    record_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    diagnosis TEXT,
    treatment TEXT,
    record_date DATE NOT NULL,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id)
);

-- Insert Specializations
INSERT INTO Specializations (name) VALUES 
('Cardiology'), ('Dermatology'), ('Pediatrics'), ('Neurology');

-- Insert Doctors
INSERT INTO Doctors (first_name, last_name, email, phone) VALUES
('Alice', 'Smith', 'alice.smith@clinic.com', '1234567890'),
('Bob', 'Johnson', 'bob.johnson@clinic.com', '0987654321');

-- Assign Specializations to Doctors
INSERT INTO DoctorSpecializations (doctor_id, specialization_id) VALUES
(1, 1), -- Alice Smith: Cardiology
(1, 4), -- Alice Smith: Neurology
(2, 2), -- Bob Johnson: Dermatology

-- Insert Patients
INSERT INTO Patients (first_name, last_name, dob, email, phone) VALUES
('John', 'Doe', '1980-06-15', 'john.doe@email.com', '1112223333'),
('Jane', 'Doe', '1990-08-20', 'jane.doe@email.com', '4445556666');

-- Insert Appointments
INSERT INTO Appointments (patient_id, doctor_id, appointment_date, reason) VALUES
(1, 1, '2025-05-15 10:00:00', 'Chest pain'),
(2, 2, '2025-05-16 14:30:00', 'Skin rash');

-- Insert Prescriptions
INSERT INTO Prescriptions (appointment_id, medication, dosage, instructions) VALUES
(1, 'Aspirin', '100mg', 'Take one tablet daily'),
(2, 'Hydrocortisone Cream', 'Apply twice daily', 'Use externally');

-- Insert Medical Records
INSERT INTO MedicalRecords (patient_id, diagnosis, treatment, record_date) VALUES
(1, 'Hypertension', 'Lifestyle changes and medication', '2025-05-01'),
(2, 'Eczema', 'Topical cream', '2025-05-03');
