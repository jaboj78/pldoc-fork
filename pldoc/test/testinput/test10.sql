package record_with_default is

    TYPE conference_type_rec IS RECORD(
        unspecified                   CHAR(3) := 'ALL'
       ,adhoc                         CHAR(5) := 'ADHOC'
       ,event                         CHAR(5) := 'EVENT'
       ,practice                      CHAR(8) := 'PRACTICE'
    );

end record_with_default;
