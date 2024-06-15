SELECT name, 
       parent_class_desc, 
       parent_id, 
       type_desc, 
       is_disabled 
FROM sys.triggers
WHERE type = 'TR';

--drop trigger DeletePlayer_trigger

SELECT name, 
       parent_class_desc, 
       parent_id, 
       type_desc, 
       is_disabled 
FROM sys.triggers
WHERE type = 'TR';