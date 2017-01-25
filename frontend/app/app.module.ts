import { NgModule }      from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { HttpModule } from '@angular/http';

import { AppComponent }   from './app.component';
import { ContentList } from './content-list.component';
import { Content } from './content.component';
import { ContentService } from './content-service';

@NgModule({
  imports:      [
    BrowserModule,
    HttpModule,
  ],
  declarations: [
    AppComponent,
    ContentList,
    Content,
  ],
  providers: [ ContentService ],
  bootstrap: [ AppComponent ],
})
export class AppModule { }
