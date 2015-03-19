-- Add a column for mgr_id in employee table
ALTER TABLE employee ADD ( mgr_id NUMBER(10));

-- Add a foreign 
ALTER TABLE employee ADD CONSTRAINT mgr_id_emp FOREIGN KEY (mgr_id) REFERENCES employee(id);

-- Define managers
UPDATE employee SET mgr_id=11  WHERE id=2;
UPDATE employee SET mgr_id=2  WHERE id=3;
UPDATE employee SET mgr_id=2  WHERE id=6;
UPDATE employee SET mgr_id=2  WHERE id=10;
UPDATE employee SET mgr_id=11  WHERE id=1;
UPDATE employee SET mgr_id=1  WHERE id=5;
UPDATE employee SET mgr_id=1  WHERE id=7;
UPDATE employee SET mgr_id=11  WHERE id=4;
UPDATE employee SET mgr_id=4  WHERE id=8;
UPDATE employee SET mgr_id=4  WHERE id=9;


COMMIT;