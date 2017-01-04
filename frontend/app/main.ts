// The browser platform with a compiler
import { platformBrowserDynamic } from '@angular/platform-browser-dynamic';
// The app module
import { AppModule } from './app.module';

import { ContentList } from './content-list.component';
// import { Content } from './content.component';

// Compile and launch the module
const platform = platformBrowserDynamic();
platform.bootstrapModule(AppModule);
