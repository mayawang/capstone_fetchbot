import { Observable } from 'RxJS/Rx';
import { Injectable } from '@angular/core';
import { Http, Response } from '@angular/http';
import { Content } from './content.component';

import 'rxjs/add/operator/map'

var API_SERVER = 'localhost:9980';

@Injectable()
export class ContentService {
  // private baseUrl: string = 'http://localhost:9080/crawl.json?spider_name=pagespider&url='

  private baseUrl: string = 'http://' + API_SERVER + '/'
  private userId: string = "242"
  private contents: any[] = []

  constructor(private http: Http) {
    this.http = http;
  }

  clearAllContents(): void {
    this.contents.splice(0, this.contents.length)
  }

  addContent(contentModel: any): void {
    this.contents.push(contentModel);
  }

  findIndexById(id): number {
    for(const content of this.contents) {
      if (content.id == id) {
        return this.contents.indexOf(content);
      }
    }

    return -1;
  }

  likeContentById(id): void {
    var index = this.findIndexById(id);
    if (index < 0) {
      console.error('cannot find content with id', id)
      return;
    }
    this.contents[index].like = true;
  }

  dislikeContentById(id): void {
    var index = this.findIndexById(id);
    if (index < 0) {
      console.error('cannot find content with id', id)
      return;
    }
    this.contents[index].like = false;
  }

  addOneNonRepeatingContent(items): void {
    var added = false;
    for (let item of items) {
      if (this.hasContentId(item.id)) {
        continue;
      }

      this.addContent(item);
      added = true;
      break;
    }

    if (!added) {
      // non-added, to ensure we do not reduce content by one , we just add the first one
      this.addContent(items[0]);
    }
  }

  deleteContentById(id): void {
    var index = this.findIndexById(id);
    if (index < 0) {
      console.error('cannot find content with id', id)
      return;
    }
    this.contents.splice(index, 1);
  }

  hasContentId(id): boolean {
    return this.findIndexById(id) >= 0;
  }

  setUserId(userId): void {
    this.userId = userId;
  }

  getContent(query): Observable<any> {
    return this.http.get( this.baseUrl + 'search' + '?q=' +
    encodeURIComponent(query) + '&uid=' +
    encodeURIComponent(this.userId))
      .map((response) => response.json());
  }

  likeContent(contentId): Observable<any> {
    return this.http.post( this.baseUrl + 'like' + '?cid=' +  encodeURIComponent(contentId) + '&uid=' +
    encodeURIComponent(this.userId), {})
      .map((response) => response.json());
  }

  dislikeContent(contentId): Observable<any> {
    return this.http.post( this.baseUrl + 'dislike' + '?cid=' +  encodeURIComponent(contentId) + '&uid='+
    encodeURIComponent(this.userId), {})
      .map((response) => response.json());
  }

  clickContent(contentId): Observable<any> {
    return this.http.post( this.baseUrl + 'click' + '?cid=' +  encodeURIComponent(contentId) + '&uid='+
    encodeURIComponent(this.userId), {})
        .map((response) => response.json());
  }

}
