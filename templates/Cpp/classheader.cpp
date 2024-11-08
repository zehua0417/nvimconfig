/**
 * @filename {{_file_name_}}.h
 * @author {{_author_}}
 * @email {{_email_}}
 * @time {{_lua:os.date("%y-%m-%d %H:%M")_}}
 * @description
 */

#ifndef __{{_upper_file_}}__
#define __{{_upper_file_}}__

/*
 * @brief definition
 */
class {{_camel_file_}}{
  private:
  // Private members
    {{_cursor_}}

  public:
    // Constructor
    {{_camel_file_}}();

    // Destructor
    ~{{_camel_file_}}();
};

#endif // __{{_upper_file_}}__
