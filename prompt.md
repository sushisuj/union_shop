
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

6. In my `EssentialsPage` (Flutter), I need three layout fixes. First, the product grid currently leaves a large pink space under each card because the grid cells are too tall—reduce the height (e.g., via `childAspectRatio`) so the cards sit compactly under their images just like on my main page. Second, eliminate the pink gap below the grid by removing extra containers/columns so only the grid plus padding remain and I can add more products later. Finally, ensure the footer stays at the very bottom of the page by using a `LayoutBuilder` + ConstrainedBox (or another approach) so that even when there are only two products, the footer doesn’t float halfway up the screen.

- Explanation of Generation: Reduced each grid cell’s height via `childAspectRatio`, removed redundant Container/Column wrappers so the grid only has padding, and wrapped the page in `LayoutBuilder` + ConstrainedBox to push the footer to the bottom even with minimal content.

- Private Notes: Learned to control grid cell height with `childAspectRatio`, simplify layouts by removing unnecessary wrappers around `GridView`, and keep the footer anchored by combining `LayoutBuilder` with a min-height `ConstrainedBox`.

7. Prompt: On my `EssentialsPage` (Flutter web), enhance the `ProductCard` so each card shows a taller product image and keeps the title/price locked to the bottom. Increase the image height (e.g., 220px), make it use `BoxFit.cover`, and wrap it in a `ClipRRect` with rounded top corners. Below the image, add a full-width text container with padding where the product name (bold) and price sit flush at the bottom with minimal spacing. Ensure the overall card layout stays identical to my main page styling.

- Explanation of Generation: Update container sizes to delete whitespace underneath product cards.

- Private Notes: Tweaking card layout involves balancing image height and text placement—use BoxFit.cover for full-bleed visuals and a padded bottom container to keep name/price aligned consistently with the main page design.

8. Build a Flutter login page that matches the UPSU style. Replace the “The UNION” text with the logo image (`https://shop.upsu.net/cdn/shop/files/upsu_300x300.png?v=1614735854`) at the top, followed by “Sign in” text, an “Enter your details to continue” subtitle, then labeled email and password fields. The primary “Continue” button should have a purple background (`#5C1FEE`) with white text, and below it include a divider with the text “Need an account?” plus an outlined “Create an account” button.

- Explanation of Generation: Create a login card utilising a rounded container with the appropriate sign in fields. Add given logo above the sign in text.

- Private Notes: Learned how to recreate a branded login card in Flutter by stacking widgets inside a centered, rounded Container, loading an external logo with Image.network, styling form fields with OutlineInputBorder, and customizing ElevatedButton/OutlinedButton colors to match brand guidelines.

9. Update the Essentials page in my Flutter app to support searchable, tag-based filtering. Convert the page to a `StatefulWidget` with an internal `_Product` model that stores `title`, `price`, `imageUrl`, and `category`. Add a filter row under the navbar containing a search `TextField` and a `DropdownButton` with “All”, “Jumpers”, “Tee”, and “Merchandise”. Each product card should belong to one of those categories. The grid must display only products whose title matches the search query and whose category matches the selected dropdown value. Keep the existing layout, promo banner, navbar, and footer intact.

- Explamation of Generatiom: The Essentials page now uses a StatefulWidget with a _Product model storing title, price, imageUrl, and category. A DropdownButton lets users filter by “All,” “Jumpers,” “Tee,” or “Merchandise,” while a TextField captures the search query. The _filteredProducts getter combines both filters—only products whose titles contain the search text and whose category matches the dropdown selection appear in the GridView.

- Private Notes: Understood how to filter products with the dropdown

10. Update `ProductPage` so it accepts dynamic data via a `ProductDetails` model (title, price, imageUrl, description) and reads that model from `ModalRoute.of(context)!.settings.arguments`. Provide a default placeholder if no arguments are passed. Then, in `main.dart`, modify each `ProductCard`’s `onTap` to call `Navigator.pushNamed('/product', arguments: ProductDetails(...))`, supplying the correct data for the men’s and women’s Essential Grey Hoodies while leaving a fallback for other products. This lets the single product_page.dart render different content depending on which homepage card is tapped.

- Explanation of Generation: Added a ProductDetails data model and updated ProductPage to read it from ModalRoute so the same screen can display dynamic content, then wired the men’s and women’s hoodie cards in main.dart to push that route with their specific details (title, price, image, description), keeping a default fallback for other products.

- Private Notes: Learned how to pass custom data through Navigator.pushNamed using a ProductDetails model so a single ProductPage can render any product dynamically, avoiding duplicate files while keeping defaults for items without data.

11. Enhance sale_page.dart so _Product and ProductCard support optional sale pricing. Card should show the original price (grey, line-through) and the discounted price (bold red) on the same row when salePrice is provided, otherwise keep the regular single-price display.

- Explanation of Generation: Added an optional salePrice field to both _Product and ProductCard, passed the value from _products, and updated the card layout so discounted items render the original price in grey with a strikethrough alongside the bold red sale price, while non-discounted products keep their single standard price display.

- Private Notes: Learned how to surface sales by adding an optional salePrice field to both the product model and card, then conditionally rendering a strike-through original price with a bold red discount when the field is present—handy pattern for any future promo listings.

12. In main.dart, make the navbar responsive. When MediaQuery.of(context).size.width is under 700, replace the three separate “Home / Shop / About Us” tabs with a single PopupMenuButton labeled “Menu” whose items navigate to the existing routes (/, /collections, /about). When width is 700 or more, keep the current inline tab row with _ShopDropdown. Use the same spacing and styling so the desktop view is unchanged, and only the mobile breakpoint collapses into the dropdown.

- Explanation of Generation: Added a width check around the navbar; on screens narrower than 700px it swaps the three inline tabs for a single “Menu” PopupMenuButton that routes to Home, Shop, or About Us, while wider screens keep the existing tab row with _ShopDropdown.

- Private Notes: Learned to use MediaQuery width checks to build responsive navbars—swap inline tabs for a single PopupMenuButton on narrow screens while preserving the desktop layout when width exceeds the breakpoint.

13. Create a reusable UnionNavBar widget in union_navbar.dart that matches the homepage navbar (banner, logo, responsive menu with _ShopDropdown, search/person/cart icons). Export it and import the widget into every page—home, sale, essentials, about, product, cart—placing const UnionNavBar() at the top of each layout, but omit it from LoginPage. Ensure the shopping bag icon navigates to /cart and the menu behaves identically across all screens. 

- Explanation of Generation: Extracted the homepage navbar into union_navbar.dart so it can be reused everywhere. Each page (home, sale, essentials, about, product, cart) now imports this widget and inserts const UnionNavBar() at the top, while LoginPage remains nav-free. The shared navbar keeps the responsive “Menu” dropdown, _ShopDropdown, and ensures the shopping bag button always routes to /cart.

- Private Notes: Learned to centralize shared chrome by moving the navbar into union_navbar.dart and reusing it across screens, keeping login isolated and ensuring the cart icon consistently routes to /cart.