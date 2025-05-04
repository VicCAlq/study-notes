# Notes on Syntax and Whatnot

1. Sort these notes later

- Rust has implicit return (last line of the block).
    - I'll use explicit returns because being explicit helps with understanding.
- Expressions can be written with or without parenthesis.
    - Rust prefers you to NOT use parenthesis. e.g.
    ```rust
    if (x < 5) {
        todo!()        // Not preferred form
    }

    if x < 5 {
        todo!()        // Preferred form
    }
    ```
- Modules:
    - `mod` defines an IN-FILE module. It's treated as if it was in another file.
        - e.g. We have to import things from the same file to access them:
        ```rust
        fn imported_function() -> bool {
            todo!()
        }

        mod inside_module {
            use crate::imported_function;
        }
        ```
    - `super` refers to parent module.
    - `crate` refers to current file.
    - `*` refers to every item.
    ```rust
    mod my_module {
        use super::other_module;      // Importing another module from parent
        use crate::*;                 // Importing everything from the file this mod is located
    }
    ```
- Function anatomy:
    ```rust
    fn my_function(param: type, arg: type) -> type {
        body
    }
    ```
    - Functions are named in snake_case.
    - Types HAVE to be explicit, both params and returns.
- Structs and Impls:
    - Structs are data types with named fields. Named with CamelCase
        ```rust
        struct MyStruct {
            field_a: type,
            name: String,
            age: u8
        }
        ```
    - Impls are the methods. They're defined OUTSIDE the structs, so they can be easily reusable.
        ```rust
        impl MyStruct {
            pub fn get_name(self) {
                return self.name;
            }
            pub fn set_name(self, name: String) {
                self.name = name;
            }
        }
        ```
- Ownership:
    - We use `&` to denote an immutable reference, and `&mut` for a mutable one.
    - There can be multiple immutable `&` references, as long as there are no mutable `&mut` ones.
    - There can be only one mutable `&mut` reference.
    - If we return a reference, we must specify it on the return type as well.
        ```rust
        fn immutable(&text: String) -> &String {
            return &text.len();
        }

        fn mutable(&mut text: String) -> &mut String {
            return format!("{} has been mutated", &text);
        }

        let mut my_text = mutable("Asdf".into()); // "Asdf has been mutated", needs to be declared as mut
        ```
    - We can also take ownership and return a modified instance.
        ```rust
        pub fn set_property(mut self, new_property: String) -> Self { 
            /// uppercase Self is an instance of type Self
            self.property = new_property;
            return self;
        }

        let new_obj = obj      // Doesn't need to be mutable because we're returning new instances
            .set_property("New prop".into())
            .set_prop2("Prop 2".into())
            .set_asdf("Asdf".into());
        ```
- Modifiers:
    - `pub`: Fields and things in Rust are private by default. Use `pub` to make them public.
        - `pub`: Accessible everythere
        - `pub(crate)`: Accessible only within the same crate.
        - `pub(super)`: Accessible within the parent module.
        - `pub(path::module)`: Accessible within the specified module.
    - `mut`: Makes it mutable.
- Keywords:
    - `let`: Creates a variable. Variables can be expressions.
    - `mod`: Declares a module.
    - `fn`: Declares a function
- Loops:
    - While syntax: `while condition { block }`
    - For syntax:
        - Range exclusive: 
            ```rust
            for n in 0..10 { block }
            ```
        - Range inclusive: 
            ```rust
            for n in 0..=10 { block }
            ```
        - Iterating on something: 
            ```rust
            for i in iterable { block }
            ```
        - Iterating on enumerate: 
            ```rust
            for (i, v) in iterable.enumerate() { block }
            ```
- Number shenanigans:
    - We can define the type of a number after typing it!
        ```rust
        123u32      = 123 as an u32 number
        10.40f64    = 10.40 as a f64 number
        ```
    - We can separate thousands, millions, etc using underscores:
        `1_000_000 = 1000000`
- Macros:
    - println! - print new line
    - assert!(thing to assert) - Asserts something, panics if false
    - assert_eq!(expr, res) - Asserts value, panics if false
    - panic! - Panics with custom message
- Types:
    1. Boolean: bool (true, false)
    2. Numbers:
        - usize - unsigned machine dependant integer.
        - isize - signed machine dependant integer.
        - u[8, 16, 32, 64] - unsigned integer with defined size.
        - i[8, 16, 32, 64] - signed integer with defined size.
        - f[32, 64] - floating point numbers.
    3. Text:
        - char - unicode value, represented as 32bit unsigned.
        - str - unicode string, as an array of u8 bytes as a sequence of UTF-8 chars.
    4. Tuple: tuple, uses ().
    5. Arrays and Slices:
        - Array - [], has fixed size, can be allocated on stack or heap.
        - Slice - [], reference to part of an array. Has no ownership.
        - Vector - Vec<type> - Dynamic array, allocated on heap only.
            ```rust
            let my_vec: Vec<u32> = (0..=10).collect::<u32>();
            // Vec<u32>      = type
            // (0..=10)      = range from 0 to 10 inclusive
            // .collect      = Makes a collection from anything iterable.
            // ::<u32>       = Type annotation to avoid errors from inference on .collect()

            let mut macro_vec = vec![100i32, 200, 300];

            macro_vec.push(400); -> [100i32, 200, 300, 400]

            // other methods:
            // .len() returns length
            // .pop() removes last element and returns it
            // .iter() iterates over vector

            for item in macro_vec.iter() {
                println!("{}", item); 
            }

            for (index, value) in macro_vec.iter().enumerate() {
                println!("pos {} value {}", index, value);
            }
            
            // To loop over and mutate items:
            for number in macro_vec.iter_mut() {
                *number += 100;
            }
            ```
    6. Structs:
        - Struct: Has fields with named keys and typed values. Has no methods written inside.
        - Impl StructName: This is how we insert methods inside structs.
        - tuple struct: Same as struct, but with unnamed fields.
        - unit-like struct: I still don't understand it.
    7. Enums:
        - enumerated type: declares only the field names.
        - enum item: declares both type and number of items.
    8. Pointers:
        - reference: & - Is a reference an object owned by another entity.
        - raw: * - Has no guarantee of safety.
        - 'static - Lifetime annotation to denote the data pointed by a reference SHALL LIVE ON.
            ```rust
            static E: i32 = -42;
            // E will exist on the binary, instead of memory-only
            ```
- Other stuff:
    - Recursion sample with factorial:
        ```rust
        fn factorial(number: u32) -> u32 {
            if (number == 0) {
                return 1;
            } 
            return number * factorial(number - 1);
        }
        ```
