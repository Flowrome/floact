**Built with Floact + Stencil**

## Notes:

Every component is a [**web-component**](https://developer.mozilla.org/en-US/docs/Web/Web_Components) so it can be used indipendently from which framework is in use.
However [**Stencil**](https://stenciljs.com/docs/react) allow to export directly the components using JSX so the code editor of choice can look through the interfaces of each web component.

So and example component could be:

- **Vanilla usage of web component**:

  ```html
  <name-of-web-component property-name="test-value"></name-of-web-component>
  ```

- **React usage of web component**:

  ```TSX
  <NameOfWebComponent propertyName={'test-value'}></NameOfWebComponent>
  ```
