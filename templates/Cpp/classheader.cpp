/**
 * @filename {{_file_name_}}.h
 * @author {{_author_}}
 * @email {{_email_}}
 * @time {{_lua:os.date("%y-%m-%d %H:%M")_}}
 * @description
 */

#ifndef __{{_file_name_}}__
#define __{{_file_name_}}__

/*
 * @brief definition
 */
class {{_file_name_}}{
  private:
  // Private members
    {{_cursor_}}

  public:
    // Constructor
    {{_file_name_}}();

    // Destructor
    ~{{_file_name_}}();
};

#endif // __{{_file_name_}}__
