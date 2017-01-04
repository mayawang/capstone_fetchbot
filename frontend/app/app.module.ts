import { NgModule }      from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { AppComponent }   from './app.component';
import { ContentList } from './content-list.component';
import { Content } from './content.component';

@NgModule({
  imports:      [ BrowserModule ],
  declarations: [
    AppComponent,
    ContentList,
    Content,
   ],
  bootstrap:    [ AppComponent ]

})
export class AppModule { }
