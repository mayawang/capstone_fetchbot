import { Observable } from 'RxJS/Rx';
import { Injectable } from '@angular/core';
import { Http, Response } from '@angular/http';
import { Content } from './content.component';

import 'rxjs/add/operator/map'

@Injectable()
export class ContentService {
  // private baseUrl: string = 'http://localhost:9080/crawl.json?spider_name=pagespider&url='

  private baseUrl: string = 'http://localhost:9980/'


  constructor(private http: Http) {
    this.http = http;
  }

  getContent(query): Observable<any> {
    return this.http.get( this.baseUrl + 'search' + '?q=' +
    encodeURIComponent(query))
      .map((response) => response.json());
  }

  likeContent(contentId, userId): Observable<any> {
    return this.http.post( this.baseUrl + 'like' + '?cid=' +  encodeURIComponent(contentId) + '?uid=' +
    encodeURIComponent(userId), {})
      .map((response) => response.json());
  }

  dislikeContent(contentId, userId): Observable<any> {
    return this.http.post( this.baseUrl + 'dislike' + '?cid=' +  encodeURIComponent(contentId) + '?uid='+
    encodeURIComponent(userId), {})
      .map((response) => response.json());
  }

  clickContent(contentId, userId): Observable<any> {
    return this.http.post( this.baseUrl + 'click' + '?cid=' +  encodeURIComponent(contentId) + '?uid='+
    encodeURIComponent(userId), {})
        .map((response) => response.json());
  }

}
