import { AngularElectronPage } from './app.po';
import { browser, element, by } from 'protractor';

describe('signet-core App', () => {
  let page: AngularElectronPage;

  beforeEach(() => {
    page = new AngularElectronPage();
  });

  it('Page title should be Signet Core', () => {
    page.navigateTo('/');
    expect(page.getTitle()).toEqual('Signet Core');
  });
});
