using Microsoft.AspNetCore.Mvc.ModelBinding;
using Microsoft.AspNetCore.Mvc.ModelBinding.Binders;

namespace DictionaryBinder.Controllers;

public class EnhancedDictionaryBinderProvider : IModelBinderProvider
{
    private readonly DictionaryModelBinderProvider _provider;

    public EnhancedDictionaryBinderProvider()
    {
        _provider = new DictionaryModelBinderProvider();
    }

    public IModelBinder GetBinder(ModelBinderProviderContext context)
    {
        var binder = _provider.GetBinder(context);
        if (binder is not null)
        {
            var binderType = typeof(EnhancedDictionaryModelBinder<,>).MakeGenericType(binder.GetType().GenericTypeArguments);
            return (IModelBinder)Activator.CreateInstance(binderType, binder);
        }

        return null;
    }
}
