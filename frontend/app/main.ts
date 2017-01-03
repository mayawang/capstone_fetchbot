import { platformBrowserDynamic } from '@angular/platform-browser-dynamic';
import { ContentList } from './content-list.component';
import { AppModule } from './app.module';
const platform = platformBrowserDynamic();
platform.bootstrapModule(AppModule);

// import { ContentStore } from './content-store..component';

// bootstrap(ContentList, [ContentStore]);
