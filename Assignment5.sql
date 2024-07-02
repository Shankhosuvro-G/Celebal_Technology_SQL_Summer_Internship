create procedure UpdateSubjectAllotments
    @StudentID varchar(50),
    @RequestedSubjectID varchar(50)
as
begin
    set nocount on;

    -- Check if the student has any active subject allotment
    declare @CurrentSubjectID varchar(50);
    select @CurrentSubjectID = SubjectID
    from SubjectAllotments
    where StudentID = @StudentID
      and Is_Valid = 1;

    if @CurrentSubjectID is null
    begin
        -- If no active allotment exists, insert the requested subject as valid
        insert into SubjectAllotments (StudentID, SubjectID, Is_Valid)
        values (@StudentID, @RequestedSubjectID, 1);
    end
    else
    begin
        -- If there is an active allotment, check if it's different from the requested subject
        if @CurrentSubjectID <> @RequestedSubjectID
        begin
            -- Invalidate the current allotment
            update SubjectAllotments
            set Is_Valid = 0
            where StudentID = @StudentID
              and Is_Valid = 1;

            -- Insert the requested subject as valid
            insert into SubjectAllotments (StudentID, SubjectID, Is_Valid)
            values (@StudentID, @RequestedSubjectID, 1);
        end
        -- If current subject is the same as requested subject, no action needed
    end
end;
