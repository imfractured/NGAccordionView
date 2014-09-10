NGAccordion Control:

Example Usage: 

    //
    NGAccordionView *av = [[NGAccordionView alloc] initWithFrame:CGRectMake(49, 140, 924.5, 450)];
    [self.view addSubview:av];

    NSArray *accordionItems = @[@"Section 1", @"Section 2", @"Section 3", @"Section 4"];
    NSArray *colors = @[@"357daa", @"56a8d8", @"006ab5", @"005a70", @"004454"];

    NSMutableArray *collection = [[NSMutableArray alloc] init];

    for ( int i = 0; i < [accordionItems count]; i++ )
    {
        // create label for content
        UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, av.frame.size.width, 350)];
        lbl.text = @"Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of 'de Finibus Bonorum et Malorum' (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, 'Lorem ipsum dolor sit amet..', comes from a line in section 1.10.32.";
        lbl.lineBreakMode = NSLineBreakByWordWrapping;
        lbl.numberOfLines = 0;
        [lbl sizeToFit];

        // create the item
        // (make sure width and height are correct)
        NGAccordionBarView *bar = [[NGAccordionBarView alloc] initWithFrame:CGRectMake(0, 0, av.frame.size.width, 97)];
        [bar setTitle:[accordionItems objectAtIndex:i] andContent:lbl];
        [bar setColor:[colors objectAtIndex:i]];
        [collection addObject:bar];
    }
    [av addObjectsToAccordion:collection];
