<script>
export default {
  name: 'MenuItem',
  functional: true,
  props: {
    icon: {
      type: String,
      default: ''
    },
    title: {
      type: String,
      default: ''
    }
  },
  render(h, context) {
    const { icon, title } = context.props
    const vnodes = []

    if (icon) {
      vnodes.push(<svg-icon icon-class={icon}/>)
    }

    if (title) {
      if (title.length > 5) {
        vnodes.push(<span style="font-weight:bold" slot='title' title={(title)}>{(title)}</span>)
      } else {
        vnodes.push(<span style="font-weight:bold" slot='title'>{(title)}</span>)
      }
    }
    return vnodes
  }
}
</script>
