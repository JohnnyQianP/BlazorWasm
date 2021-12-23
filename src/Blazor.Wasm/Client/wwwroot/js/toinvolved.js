window.diyfunction = {
    alertMsg: function (msg) {
        alert(msg);
    },
    calldotnetfun: function () {
        DotNet.invokeMethodAsync('Blazor.Wasm.Client', 'FromDotnetFunAsync')
            .then(data => {
                alert(data);
            });
    },
    calldotnetfun2: function (dotNetHelper) {
        var xx = dotNetHelper.invokeMethodAsync('FromDotnetFun2');
        return xx
    }
}