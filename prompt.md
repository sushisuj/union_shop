
## Prompt Bank
- This document will act as a library of prompts used throughout the development of this coursework for documentation and future reference.

## Layout Of Document
- Prompt (What I said to the LLM)
- Explanation (Explanation of what changes were made to my file by AI)
- Private Notes (Notes so I can understand what the AI has generated, including new concepts)

## Prompts
1. I am creating an online shop program in which this is my footer section. a picture of my footer is included for context. Within my footer, i want the text below the title "Help and information" to be turned into dummy links as opposed to staying as plain text.

- Explanation of Generation: Turns my plain text in the footer into dummy links (mimicing a working webpage). AI inserts "Gesture Detector" and "MouseRegion"

- Private Notes: A GestureDetector in Flutter is a widget that detects and responds to user touch interactions, such as taps, drags, and swipes. A MouseRegion in Flutter is a widget that detects when the mouse pointer enters, exits, or hovers over its child, enabling hover effects and cursor changes.


2. I want to add an "About Us" tab to my navigation bar at the top of the page. Use image attached for context. This tab should be clickable and, when clicked, should navigate the user to a separate About Us page. Please indicate where I should insert the destination route in the code.

- Explanation of Generation: Added a clickable "About Us" tab to the navigation bar using a GestureDetector, and indicated where to insert the navigation route (Navigator.pushNamed(context, '/about')) to open the About Us page.

- Private Notes: A navigation tab can be made clickable using a GestureDetector, and navigation between pages in Flutter is handled with Navigator.pushNamed and defined routes. Always import the target page and add its route to MaterialApp for seamless navigation.


3. I have two product images ("Essential Grey Hoodie Mens" and "Essential Grey Hoodie Womens") in my online shop, but they appear at different sizes. How can I ensure both images display at the same size for a consistent layout, regardless of their original dimensions?

- Explanation of Generation: Wrapped both product images in a SizedBox with a fixed height and width, ensuring they display at the same size regardless of their original dimensions, which creates a consistent layout in your product grid.

- Private Notes: Next time you have 2 or more images of different sizes, you can contain them in a sized box which should restrict/resize images.

4. I have added a "Shop" dropdown tab to my navbar. I want the dropdown menu to appear above all page content, including the hero section, so that it overlays the hero and avoids any overflow errors when expanded.

- Explanation of Generation: Implemented the "Shop" dropdown using an OverlayEntry so the menu appears above all page content, including the hero section, preventing overflow errors when expanded.

- Private Notes: OverlayEntry lets you display widgets above all other content, making it ideal for dropdowns and popups that need to overlay sections like the hero without causing layout or overflow issues.

5. I want the "Shop" button in my navbar to navigate to a dedicated collections page. This page should feature a "Collections" title and display four smaller, hero-style boxes for "Essentials," "Winter Collection," "Merchandise," and "Personalisation." Each box should use an image with 0.7 opacity and overlayed text for the title. The navbar should only include "Home," "Shop," and "About Us" tabs. At the top, add a purple header with the text "Our Biggest Sale of the Year is Here! Up to 50% Off Selected Items. Shop Now!" and the footer should match the one used in my main file.

- Created a collections page with a "Collections" title, four hero-style boxes for each collection (using images with 0.7 opacity and overlayed text), a simplified navbar, a purple promotional header, and a footer matching your main file.

- Private Notes: When creating a collections page, you can use a hero-style layout with images and overlayed text for each collection. To keep the design consistent, use a simplified navbar and reuse components like the purple header and footer from your main file. For overlay effects, set the image opacity and use a Stack to layer text on top.

6. In my EssentialsPage (Flutter), I need three layout fixes. First, the product grid currently leaves a large pink space under each card because the grid cells are too tall—reduce the height (e.g., via childAspectRatio) so the cards sit compactly under their images just like on my main page. Second, eliminate the pink gap below the grid by removing extra containers/columns so only the grid plus padding remain and I can add more products later. Finally, ensure the footer stays at the very bottom of the page by using a LayoutBuilder + ConstrainedBox (or another approach) so that even when there are only two products, the footer doesn’t float halfway up the screen.

- Explanation of Generation: Reduced each grid cell’s height via childAspectRatio, removed redundant Container/Column wrappers so the grid only has padding, and wrapped the page in LayoutBuilder + ConstrainedBox to push the footer to the bottom even with minimal content.

- Private Notes: Learned to control grid cell height with childAspectRatio, simplify layouts by removing unnecessary wrappers around GridView, and keep the footer anchored by combining LayoutBuilder with a min-height ConstrainedBox.