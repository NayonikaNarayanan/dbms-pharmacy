EXEC Insert_Doctor('111111111111', 'Dr. Asha Reddy', 'Cardiology', 12);
EXEC Insert_Doctor('222222222222', 'Dr. Ramesh Mehta', 'Orthopedics', 15);
EXEC Insert_Doctor('333333333333', 'Dr. Leena Sharma', 'Pediatrics', 10);
EXEC Insert_Doctor('444444444444', 'Dr. Imran Qureshi', 'Dermatology', 8);
EXEC Insert_Doctor('555555555555', 'Dr. Sunita Menon', 'Neurology', 14);



EXEC Insert_Patient('666666666666', 'Aarav Kumar', '101 MG Road, Bangalore', 30, '111111111111');
EXEC Insert_Patient('777777777777', 'Maya Nair', '12 Park St, Mumbai', 25, '222222222222');
EXEC Insert_Patient('888888888888', 'Rohan Desai', '3 Nehru Ave, Pune', 40, '333333333333');
EXEC Insert_Patient('999999999999', 'Tanya Verma', '55 Civil Lines, Delhi', 35, '444444444444');
EXEC Insert_Patient('000000000000', 'Zoya Sheikh', '18 Hill View, Hyderabad', 28, '555555555555');
EXEC Insert_Patient('123123123123', 'Karan Singh', '2 Ring Road, Lucknow', 45, '111111111111');
EXEC Insert_Patient('234234234234', 'Priya Das', '7 Station Road, Kolkata', 32, '222222222222');
EXEC Insert_Patient('345345345345', 'Devika Rao', '90 Beach Road, Chennai', 29, '333333333333');
EXEC Insert_Patient('456456456456', 'Kabir Shah', '13 Green Avenue, Bhopal', 38, '444444444444');
EXEC Insert_Patient('567567567567', 'Neha Pandey', '101 Hilltop Lane, Jaipur', 41, '555555555555');



EXEC Insert_PharmaCompany('MediLife', '0801234567');
EXEC Insert_PharmaCompany('CureWell', '0802345678');
EXEC Insert_PharmaCompany('HealthPlus', '0803456789');
EXEC Insert_PharmaCompany('BioZen', '0804567890');




EXEC Insert_Drug('PainAway', 'MediLife', 'Ibuprofen 400mg');
EXEC Insert_Drug('CoughGo', 'MediLife', 'Dextromethorphan 15mg');
EXEC Insert_Drug('HealFast', 'CureWell', 'Amoxicillin 500mg');
EXEC Insert_Drug('FluFree', 'CureWell', 'Oseltamivir 75mg');
EXEC Insert_Drug('AllerNil', 'HealthPlus', 'Loratadine 10mg');
EXEC Insert_Drug('ColdCure', 'HealthPlus', 'Phenylephrine + CPM');
EXEC Insert_Drug('NeuroCalm', 'BioZen', 'Pregabalin 75mg');
EXEC Insert_Drug('SkinSure', 'BioZen', 'Clotrimazole 1%');
EXEC Insert_Drug('HeartGuard', 'MediLife', 'Atenolol 50mg');
EXEC Insert_Drug('BoneStrong', 'CureWell', 'Calcium + Vitamin D3');


EXEC Insert_Pharmacy('Apollo RX', '22 Brigade Road, Bangalore', '0800000001');
EXEC Insert_Pharmacy('WellCare', '11 Hill Road, Mumbai', '0800000002');


EXEC Insert_Contract(1, 'Apollo RX', 'MediLife', 'Rajesh Kumar', 'Supply of general medicine', TO_DATE('2023-01-01','YYYY-MM-DD'), TO_DATE('2025-01-01','YYYY-MM-DD'));
EXEC Insert_Contract(2, 'WellCare', 'CureWell', 'Anjali Verma', 'Seasonal flu vaccines', TO_DATE('2024-03-15','YYYY-MM-DD'), TO_DATE('2025-03-14','YYYY-MM-DD'));


EXEC Insert_Prescription(101, '666666666666', '111111111111', TO_DATE('2025-04-01','YYYY-MM-DD'));
EXEC Insert_Prescription(102, '777777777777', '222222222222', TO_DATE('2025-04-02','YYYY-MM-DD'));
EXEC Insert_Prescription(103, '888888888888', '333333333333', TO_DATE('2025-04-03','YYYY-MM-DD'));
EXEC Insert_Prescription(104, '999999999999', '444444444444', TO_DATE('2025-04-04','YYYY-MM-DD'));
EXEC Insert_Prescription(105, '000000000000', '555555555555', TO_DATE('2025-04-05','YYYY-MM-DD'));
EXEC Insert_Prescription(106, '666666666666', '222222222222', TO_DATE('2025-04-06','YYYY-MM-DD'));
EXEC Insert_Prescription(107, '777777777777', '333333333333', TO_DATE('2025-04-07','YYYY-MM-DD'));
EXEC Insert_Prescription(108, '888888888888', '444444444444', TO_DATE('2025-04-08','YYYY-MM-DD'));
EXEC Insert_Prescription(109, '999999999999', '555555555555', TO_DATE('2025-04-09','YYYY-MM-DD'));
EXEC Insert_Prescription(110, '000000000000', '111111111111', TO_DATE('2025-04-10','YYYY-MM-DD'));
EXEC Insert_Prescription(111, '123123123123', '111111111111', TO_DATE('2025-04-11','YYYY-MM-DD'));
EXEC Insert_Prescription(112, '234234234234', '222222222222', TO_DATE('2025-04-12','YYYY-MM-DD'));
EXEC Insert_Prescription(113, '345345345345', '333333333333', TO_DATE('2025-04-13','YYYY-MM-DD'));
EXEC Insert_Prescription(114, '456456456456', '444444444444', TO_DATE('2025-04-14','YYYY-MM-DD'));
EXEC Insert_Prescription(115, '567567567567', '555555555555', TO_DATE('2025-04-15','YYYY-MM-DD'));





EXEC Insert_Sales('Apollo RX', 'PainAway', 'MediLife', 12.5);
EXEC Insert_Sales('Apollo RX', 'CoughGo', 'MediLife', 10.0);
EXEC Insert_Sales('Apollo RX', 'HeartGuard', 'MediLife', 18.0);
EXEC Insert_Sales('Apollo RX', 'AllerNil', 'HealthPlus', 15.0);
EXEC Insert_Sales('Apollo RX', 'ColdCure', 'HealthPlus', 16.5);
EXEC Insert_Sales('Apollo RX', 'NeuroCalm', 'BioZen', 35.0);
EXEC Insert_Sales('Apollo RX', 'SkinSure', 'BioZen', 12.0);
EXEC Insert_Sales('Apollo RX', 'HealFast', 'CureWell', 25.0);
EXEC Insert_Sales('Apollo RX', 'FluFree', 'CureWell', 30.0);
EXEC Insert_Sales('Apollo RX', 'BoneStrong', 'CureWell', 22.0);


EXEC Insert_Sales('WellCare', 'PainAway', 'MediLife', 13.0);
EXEC Insert_Sales('WellCare', 'CoughGo', 'MediLife', 11.0);
EXEC Insert_Sales('WellCare', 'HeartGuard', 'MediLife', 19.0);
EXEC Insert_Sales('WellCare', 'AllerNil', 'HealthPlus', 14.5);
EXEC Insert_Sales('WellCare', 'ColdCure', 'HealthPlus', 17.0);
EXEC Insert_Sales('WellCare', 'NeuroCalm', 'BioZen', 36.0);
EXEC Insert_Sales('WellCare', 'SkinSure', 'BioZen', 12.5);
EXEC Insert_Sales('WellCare', 'HealFast', 'CureWell', 26.0);
EXEC Insert_Sales('WellCare', 'FluFree', 'CureWell', 31.0);
EXEC Insert_Sales('WellCare', 'BoneStrong', 'CureWell', 23.0);







EXEC Insert_PrescriptionDrug(101, 'PainAway', 'MediLife', 2);
EXEC Insert_PrescriptionDrug(101, 'CoughGo', 'MediLife', 1);


EXEC Insert_PrescriptionDrug(102, 'HealFast', 'CureWell', 1);
EXEC Insert_PrescriptionDrug(106, 'FluFree', 'CureWell', 2);

EXEC Insert_PrescriptionDrug(103, 'ColdCure', 'HealthPlus', 1);
EXEC Insert_PrescriptionDrug(107, 'AllerNil', 'HealthPlus', 2);


EXEC Insert_PrescriptionDrug(104, 'SkinSure', 'BioZen', 1);
EXEC Insert_PrescriptionDrug(108, 'NeuroCalm', 'BioZen', 1);


EXEC Insert_PrescriptionDrug(105, 'HeartGuard', 'MediLife', 1);
EXEC Insert_PrescriptionDrug(109, 'BoneStrong', 'CureWell', 1);
EXEC Insert_PrescriptionDrug(110, 'PainAway', 'MediLife', 1);
EXEC Insert_PrescriptionDrug(110, 'AllerNil', 'HealthPlus', 1);
EXEC Insert_PrescriptionDrug(111, 'PainAway', 'MediLife', 1);
EXEC Insert_PrescriptionDrug(111, 'AllerNil', 'HealthPlus', 2);

EXEC Insert_PrescriptionDrug(112, 'FluFree', 'CureWell', 1);

EXEC Insert_PrescriptionDrug(113, 'ColdCure', 'HealthPlus', 1);
EXEC Insert_PrescriptionDrug(113, 'SkinSure', 'BioZen', 1);

EXEC Insert_PrescriptionDrug(114, 'HeartGuard', 'MediLife', 1);
EXEC Insert_PrescriptionDrug(114, 'HealFast', 'CureWell', 2);

EXEC Insert_PrescriptionDrug(115, 'BoneStrong', 'CureWell', 1);


exec print_contract_details('Apollo RX','MediLife');

exec Prescription_Report('666666666666',TO_DATE('2025-04-02','YYYY-MM-DD'),TO_DATE('2025-04-07','YYYY-MM-DD'));

exec prescription_details_by_date('999999999999',to_date('2025-04-09','yyyy-mm-dd'));